import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'diseasedata.dart'; // Import the disease data

void main() {
  runApp(const MaterialApp(
    home: CameraPage(),
  ));
}

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  bool _isFlashOn = false;
  bool _pictureTaken = false;

  @override
  void initState() {
    super.initState();
    loadModels();
    _initializeCamera();
  }

  Future<void> loadModels() async {
    List<String> modelNames = [
      'brownspot', 'hispa', 'leafblast', 'leafblight', 'tungro'
    ];

    for (String modelName in modelNames) {
      await Tflite.loadModel(
        model: 'assets/models/$modelName.tflite',
        labels: 'assets/models/$modelName.txt',
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    setState(() {
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  Future<void> _takePicture() async {
    // If a picture has already been taken, don't take another one
    if (_pictureTaken) {
      return;
    }

    try {
      final XFile file = await _controller.takePicture();
      await GallerySaver.saveImage(file.path, albumName: "Camera Roll");

      double maxAccuracy = 0.0;
      String selectedModel = 'Unknown';

      // Load the models outside the loop
      for (String modelName in ['brownspot', 'hispa', 'leafblast', 'leafblight', 'tungro']) {
        List<dynamic>? output = await Tflite.runModelOnImage(
          path: file.path,
          numResults: 2,
          threshold: 0.2,
          asynch: true,
        );

        double accuracy = (output != null && output.isNotEmpty) ? output[0]['confidence'] : 0.0;

        print('Model: $modelName, Accuracy: $accuracy');

        if (accuracy > maxAccuracy) {
          maxAccuracy = accuracy;
          selectedModel = modelName;
        }
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          Disease selectedDisease = diseaseList.firstWhere((d) => d.name.toLowerCase() == selectedModel);

          return AlertDialog(
            title: const Text('Prediction Result'),
            content: Text('The captured image is predicted by the model $selectedModel with $maxAccuracy% accuracy.'),
            actions: [
              TextButton(
                 onPressed: () {
                  _resetPicture(); // Reset the flag
                  Navigator.of(context).pop();
                },
                child: const Text('Retake'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseaseDetailScreen(
                        disease: selectedDisease,
                      ),
                    ),
                  );
                },
                child: const Text('View Details'),
              ),
            ],
          );
        },
      );

      // Set the flag to indicate that a picture has been taken
      setState(() {
        _pictureTaken = true;
      });
    } catch (e) {
      print('Error capturing and saving photo: $e');
    }
  }

  void _resetPicture() {
    setState(() {
      _pictureTaken = false;
    });
  }

void _toggleFlash() {
  setState(() {
    if (_controller.value.flashMode == FlashMode.off) {
      _controller.setFlashMode(FlashMode.torch);
      _isFlashOn = true;
    } else {
      _controller.setFlashMode(FlashMode.off);
      _isFlashOn = false;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 400.0,
                    height: 600.0,
                    child: CameraPreview(_controller),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0), // Add spacing
          GestureDetector(
             onTap: () {
                  _takePicture();
                  _resetPicture(); // Reset the flag when tapping the camera button
                },
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: const Center(
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _toggleFlash,
            child: Text(_isFlashOn ? 'Turn Off Flash' : 'Turn On Flash'),
          ),
        ],
      ),
    );
  }
}