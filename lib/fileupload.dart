import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'diseasedata.dart'; // Import the disease data

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<dynamic> _output = [];
  File? _image;
  Map<String, String> modelPaths = {
    'brownspot': 'brownspot.tflite',
    'hispa': 'hispa.tflite',
    'leafblast': 'leafblast.tflite',
    'leafblight': 'leafblight.tflite',
    'tungro': 'tungro.tflite',
  };
  Map<String, String> labelPaths = {
    'brownspot': 'brownspot.txt',
    'hispa': 'hispa.txt',
    'leafblast': 'leafblast.txt',
    'leafblight': 'leafblight.txt',
    'tungro': 'tungro.txt',
  };

  @override
  void initState() {
    super.initState();
    // Load the default model (e.g., brownspot)
    loadModel('brownspot');
  }

  Future<void> loadModel(String modelName) async {
    String modelPath = 'assets/models/${modelPaths[modelName]}';
    String labelPath = 'assets/models/${labelPaths[modelName]}';
    await Tflite.loadModel(model: modelPath, labels: labelPath);
  }

  Future<List<dynamic>> runModel(File image) async {
    List<dynamic>? output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2, // Adjust based on your model
      threshold: 0.2, // Adjust based on your model
    );
    return output ?? [];
  }

  Future<void> _selectAndPredictImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      List<Map<String, dynamic>> predictions = [];

      // Run the models for each disease
      for (String disease in modelPaths.keys) {
        List<dynamic> output = await runModel(image);
        predictions.add({
          'disease': disease,
          'accuracy': (output.isNotEmpty ? (output[0]['confidence'] as double) : 0.0),
        });
      }

      // Select the disease with the highest accuracy
      predictions.sort((a, b) => (b['accuracy'] as double).compareTo(a['accuracy'] as double));
      String selectedDisease = predictions[0]['disease'] as String;

      // Display an AlertDialog with prediction results and a button to view details
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Disease selectedDiseaseData = diseaseList.firstWhere((d) => d.name.toLowerCase() == selectedDisease);

          return AlertDialog(
            title: const Text('Prediction Result'),
            content: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Selected Disease: $selectedDisease'),
                  Text('Accuracy: ${predictions[0]['accuracy'] * 100}%'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseaseDetailScreen(
                        disease: selectedDiseaseData,
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

      setState(() {
        _image = image;
        _output = predictions;
      });
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detection App'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('Select an image to predict')
                : Image.file(_image!, height: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectAndPredictImage,
              child: Text('Select and Predict Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            if (_output.isNotEmpty)
              Text('Selected Disease: ${_output[0]['disease']}'),
            if (_output.isNotEmpty)
              Text('Accuracy: ${(_output[0]['accuracy'] * 100).toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: UploadPage()));
