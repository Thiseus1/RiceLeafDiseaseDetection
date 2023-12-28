import 'package:flutter/material.dart';
import 'diseasedata.dart'; // Import the disease data

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DISEASES'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: diseaseList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // Define the detail screen widget here
                    return DiseaseDetailScreen(disease: diseaseList[index]); // Pass the Disease object
                  },
                ),
              );
              // Handle item click here, e.g., navigate to a detail screen
            },
            child: Container(
              margin: EdgeInsets.all(9.0), // Adjust margin as needed
              padding: EdgeInsets.all(9.0), // Adjust padding as needed
              decoration: BoxDecoration(
                color: Colors.green, // Set background color
                borderRadius: BorderRadius.circular(10.0), // Add border radius
              ),
              child: Row(
                children: [
                  Image(
                    image: AssetImage(diseaseList[index].imageUrl),
                    width: MediaQuery.of(context).size.width * 0.4, // Adjust the percentage as needed
                    height: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10.0), // Add spacing between image and text
                  Text(
                    diseaseList[index].name,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05,),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
