import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDataScreen extends StatelessWidget {
  final User userData; // Accept user data as a parameter
  const UserDataScreen(this.userData, {super.key});

  Color getStatusColor(User userData) {
    if (userData.status == 'valid') {
      return Colors.green;
    }
    if (userData.status == 'used') {
      return Colors.orange;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getStatusColor(userData),
        appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 2, // Add elevation for a raised effect
            margin: const EdgeInsets.all(14), // Add margin for the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              side: const BorderSide(width: 2), // Border
            ),
            child: Container(
              padding: const EdgeInsets.all(14), // Add padding for spacing
              width: double.infinity, // Expand to full width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Participant Information:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45, // Text color
                    ),
                  ),

                  const SizedBox(height: 14), // Spacing below the title
                  buttonLikeRow('Name:', userData.name),
                  buttonLikeRow('Email:', userData.email),
                  buttonLikeRow('Event:', userData.eventName),
                  buttonLikeRow('Age:', userData.ageAtEventStart.toString()),
                  buttonLikeRow('Status:', userData.status),
                  buttonLikeRow('Entry Time:', userData.entryTime),
                  ],
              ),
            ),
          ),
          Card(
            elevation: 2, // Add elevation for a raised effect
            margin: const EdgeInsets.all(14), // Add margin for the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              side: const BorderSide(width: 2), // Border
            ),
            child: Container(
              padding: const EdgeInsets.all(14), // Add padding for spacing
              width: double.infinity, // Expand to full width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Item Information:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45, // Text color
                    ),
                  ),

                  const SizedBox(height: 16), // Spacing below the title
                  for (var item in userData.items.entries) ...[
                    buttonLikeRow(item.key.toString(), userData.items[item.key].toString()),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16), // Margin between the card and other content
        ],
      ),
    );
  }

  Widget buttonLikeRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4), // Add vertical margin
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(width: 2), // Border
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
