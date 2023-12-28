import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<dynamic> _output = [];
  File? _image;
  String _selectedModel = 'brownspot'; // Default to 'brownspot'

  // Define a mapping of model names to their corresponding files
  final modelFiles = {
    'brownspot': 'brownspot.tflite',
    'hispa': 'hispa.tflite',
    'leafblast': 'leafblast.tflite',
    'tungro': 'tungro.tflite',
  };

  final labelPaths = {
    'brownspot': 'brownspot.txt',
    'hispa': 'hispa.txt',
    'leafblast': 'leafblast.txt',
    'tungro': 'tungro.txt',
  };

  @override
  void initState() {
    super.initState();
    loadModel(modelName: _selectedModel);
  }

  Future<void> loadModel({required String modelName}) async {
    String modelPath = 'assets/models/${modelFiles[modelName]}';
    String labelPath = 'assets/models/$modelName.txt';

    await Tflite.loadModel(model: modelPath, labels: labelPath);
  }

  Future<void> _selectAndPredictImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      // Store the predictions from all models
      Map<String, List<dynamic>> predictions = {};

      // Run inference for all models
      modelFiles.forEach((modelName, modelFile) async {
        List<dynamic>? output = await Tflite.runModelOnImage(
          path: image.path,
          numResults: 2, // Adjust based on your model
          threshold: 0.2, // Adjust based on your model
        );
        predictions[modelName] = output!;
      });

      // Determine the model with the highest accuracy
      String bestModel = _selectedModel; // Default to the selected model
      double highestConfidence = 0.0;

      predictions.forEach((modelName, output) {
        double confidence = output[0]['confidence'];
        if (confidence > highestConfidence) {
          highestConfidence = confidence;
          bestModel = modelName;
        }
      });

      setState(() {
        _image = image;
        _output = predictions[bestModel]!;
        _selectedModel = bestModel;
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
        title: Text('Upload Page'),
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
            Text('Selected Model: $_selectedModel'),
            if (_output.isNotEmpty)
              Text('Prediction: ${_output[0]['label']}'),
            DropdownButton<String>(
              value: _selectedModel,
              items: modelFiles.keys
                  .map((model) => DropdownMenuItem(
                        value: model,
                        child: Text(model),
                      ))
                  .toList(),
              onChanged: (newModel) {
                setState(() {
                  _selectedModel = newModel!;
                  // Load the selected model
                  loadModel(modelName: _selectedModel);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
