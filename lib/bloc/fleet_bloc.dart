import 'package:flutter_bloc/flutter_bloc.dart';

// Define BLoC events
abstract class FleetEvent {}

class FetchDataEvent extends FleetEvent {}

// Define BLoC states
abstract class FleetState {}

class FleetInitialState extends FleetState {}

class FleetLoadedState extends FleetState {
  final Map<String, dynamic> vehicleData;

  FleetLoadedState(this.vehicleData);
}

class FleetBloc extends Bloc<FleetEvent, FleetState> {
  FleetBloc() : super(FleetInitialState());

  @override
  Stream<FleetState> mapEventToState(FleetEvent event) async* {
    if (event is FetchDataEvent) {
      try {
        // Fetch data from the backend or GPS tracker API
        // Update the state with the retrieved data
        Map<String, dynamic> mockData = {
          'gps': 'Latitude: 37.7749, Longitude: -122.4194',
          'accidentDetection': false,
          'speed': '65 km/h',
          'antiTheftAlarm': false,
          'ignitionDetection': true,
        };

        yield FleetLoadedState(mockData);
      } catch (error) {
        // Emit an error state if there's an issue
        yield FleetLoadedState({'error': 'Error fetching data: $error'});
      }
    }
  }
}

