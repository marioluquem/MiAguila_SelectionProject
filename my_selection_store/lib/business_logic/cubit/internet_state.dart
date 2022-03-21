part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  final InternetType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
