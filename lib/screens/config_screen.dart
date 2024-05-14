import 'package:flutter/material.dart';
import '../models/config.dart'; // Import the AppConfig model

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  ConfigScreenState createState() => ConfigScreenState();
}

class ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController kissjInstanceController = TextEditingController();
  final TextEditingController eventSecretController = TextEditingController();

  late AppConfig config; // Initialize AppConfig in the initState method

  @override
  void initState() {
    super.initState();

    // Initialize AppConfig and load saved configuration when the screen initializes
    config = AppConfig();
    config.initialize().then((_) {
      setState(() {
        kissjInstanceController.text = config.kissjInstance;
        eventSecretController.text = config.eventSecret;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Configure Kissj API')
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Kissj Instance URL:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: kissjInstanceController,
              decoration: const InputDecoration(
                hintText: 'Enter kissj Instance URL',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Event Secret:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: eventSecretController,
              decoration: const InputDecoration(
                hintText: 'Enter event Secret',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveConfig,
              child: const Text('Save Configuration'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveConfig() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Update the AppConfig instance
    config.kissjInstance = kissjInstanceController.text;
    config.eventSecret = eventSecretController.text;

    // Save the configuration to SharedPreferences
    await config.saveConfig();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configuration saved.'),
        ),
      );
    }
  }
}

