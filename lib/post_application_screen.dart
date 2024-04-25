
import 'package:flutter/material.dart';

class Application {
  final String name;
  final String address;
  final String contact;
  final DateTime applicationDate;
  final DateTime connectionDate;
  final DateTime relaunchDate;
  final String status;

  Application({
    required this.name,
    required this.address,
    required this.contact,
    required this.applicationDate,
    required this.connectionDate,
    required this.relaunchDate,
    required this.status,
  });
}

class PostApplicationScreen extends StatefulWidget {
  const PostApplicationScreen({super.key});

  @override
  State<PostApplicationScreen> createState() => _PostApplicationScreenState();
}

class _PostApplicationScreenState extends State<PostApplicationScreen> {
  final List<Application> applications = [
    Application(
      name: 'ABC Company',
      address: '123 Main Street',
      contact: 'John Doe',
      applicationDate: DateTime(2022, 1, 1),
      connectionDate: DateTime(2022, 1, 15),
      relaunchDate: DateTime(2022, 2, 1),
      status: 'Accepted',
    ),
    Application(
      name: 'ABC Company',
      address: '123 Main Street',
      contact: 'John Doe',
      applicationDate: DateTime(2022, 1, 1),
      connectionDate: DateTime(2022, 1, 15),
      relaunchDate: DateTime(2022, 2, 1),
      status: 'Denied',
    ),
    Application(
      name: 'ABC Company',
      address: '123 Main Street',
      contact: 'John Doe',
      applicationDate: DateTime(2022, 1, 1),
      connectionDate: DateTime(2022, 1, 15),
      relaunchDate: DateTime(2022, 2, 1),
      status: 'Denied',
    ),
    Application(
      name: 'ABC Company',
      address: '123 Main Street',
      contact: 'John Doe',
      applicationDate: DateTime(2022, 1, 1),
      connectionDate: DateTime(2022, 1, 15),
      relaunchDate: DateTime(2022, 2, 1),
      status: 'Accepted',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Company Applications'),
        ),
        body: ListView.builder(
          itemCount: applications.length,
          itemBuilder: (context, index) {
            return buildApplicationCard(context, applications[index]);
          },
        ),
      );
  }


  Widget buildApplicationCard(BuildContext context, Application application) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          application.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${application.address}'),
            Text('Contact: ${application.contact}'),
            const SizedBox(height: 8),
            Text(
              'Application Date: ${application.applicationDate.toString()}',
            ),
            Text(
              'Connection Date: ${application.connectionDate.toString()}',
            ),
            Text(
              'Relaunch Date: ${application.relaunchDate.toString()}',
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${application.status}',
              style: TextStyle(
                color: application.status == 'Accepted'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApplicationDetailsScreen(application),
            ),
          );
        },
      ),
    );
  }
}


class ApplicationDetailsScreen extends StatelessWidget {
  final Application application;

  const ApplicationDetailsScreen(this.application, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Name: ${application.name}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text('Address: ${application.address}'),
            Text('Contact: ${application.contact}'),
            const SizedBox(height: 16),
            Text('Application Date: ${application.applicationDate.toString()}'),
            Text('Connection Date: ${application.connectionDate.toString()}'),
            Text('Relaunch Date: ${application.relaunchDate.toString()}'),
            const SizedBox(height: 16),
            Text(
              'Status: ${application.status}',
              style: TextStyle(
                color: application.status == 'Accepted'
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}