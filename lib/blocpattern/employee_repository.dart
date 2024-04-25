// employee_repository.dart
import 'employee_model.dart';

class EmployeeRepository {
  List<Employee> getEmployees() {
    // Simulation de récupération des employés depuis une source de données
    return [
      Employee(id: 1, name: 'John Doe'),
      Employee(id: 2, name: 'Jane Smith'),
      Employee(id: 3, name: 'Alice Johnson'),
    ];
  }
}
