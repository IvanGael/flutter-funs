
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointManagementScreen extends StatelessWidget {
  const AppointManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfessionalsListScreen()),
                );
              },
              child: const Text('Find Professionals'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfessionalsListScreen extends StatelessWidget {
  const ProfessionalsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppointmentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Professionals List'),
      ),
      body: FutureBuilder(
        future: provider.loadProfessionals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading professionals'));
          } else {
            return ListView.builder(
              itemCount: provider.professionals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.professionals[index].name),
                  onTap: () {
                    provider.selectProfessional(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfessionalDetailsScreen()),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProfessionalDetailsScreen extends StatelessWidget {
  const ProfessionalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppointmentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Details'),
      ),
      body: provider.selectedProfessional != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(provider.selectedProfessional!.name),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement booking logic
                    provider.bookAppointment(provider.selectedProfessional!);
                  },
                  child: const Text('Book Appointment'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the Professionals List screen
                  },
                  child: const Text('Go Back'),
                ),
              ],
            )
          : const Center(child: Text('Error loading professional details')),
    );
  }
}

class AppointmentProvider with ChangeNotifier {
  List<Professional> professionals = [];
  Professional? selectedProfessional;

  Future<void> loadProfessionals() async {
    // Simulate loading professionals from a network request
    await Future.delayed(const Duration(seconds: 10));
    professionals = [
      Professional(name: 'John Doe'),
      Professional(name: 'Jane Smith'),
      Professional(name: 'Diego Diaz'),
      Professional(name: 'Gortone bartolomeo'),
      Professional(name: 'Eric Montenegro'),
      Professional(name: 'Carlos Ricalde'),
    ];
    notifyListeners();
  }

  void selectProfessional(int index) {
    selectedProfessional = professionals[index];
    notifyListeners();
  }

  void bookAppointment(Professional professional) {
    // Implement booking logic here
    // You can update the state or send the booked appointment to a backend service
  }
}

class Professional {
  final String name;

  Professional({required this.name});
}