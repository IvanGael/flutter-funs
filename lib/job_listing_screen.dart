
import 'package:flutter/material.dart';

class JobListingScreen extends StatelessWidget {
  const JobListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Job Listing'),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            CompanyDetailsCard(),
            SizedBox(height: 16),
            JobDetailsCard(),
            SizedBox(height: 16),
            BenefitsCard(),
            SizedBox(height: 16),
            AboutUsCard(),
            SizedBox(height: 16),
            FunFactsCard(),
          ],
        ),
      );
  }
}

class CompanyDetailsCard extends StatelessWidget {
  const CompanyDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company: XYZ Innovations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Website: www.xyzinnovations.com',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              'Social Media: @XYZInnovations',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class JobDetailsCard extends StatelessWidget {
  const JobDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Position: Senior Mobile Developer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Location: New York, NY',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Type: Full-Time',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Experience: 5+ years',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class BenefitsCard extends StatelessWidget {
  const BenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Benefits:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- Competitive Salary'),
            Text('- Health Insurance'),
            Text('- Flexible Work Hours'),
            Text('- Stock Options'),
          ],
        ),
      ),
    );
  }
}

class AboutUsCard extends StatelessWidget {
  const AboutUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'XYZ Innovations is a cutting-edge technology company focused on creating innovative solutions for our clients. Our team is composed of talented individuals who are passionate about pushing the boundaries of technology and delivering exceptional results.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class FunFactsCard extends StatelessWidget {
  const FunFactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fun Facts:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- We have a pet-friendly office'),
            Text('- Monthly team-building activities'),
            Text('- Annual company retreat to the Caribbean'),
            Text('- Free snacks and coffee in the break room'),
          ],
        ),
      ),
    );
  }
}