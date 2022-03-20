part of 'internet_cubit.dart';

@immutable
abstract class InternetconnectionState {}

class InternetconnectionInitial extends InternetconnectionState {}

class InternetConnected extends InternetconnectionState {
  final InternetConnectionType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetconnectionState {}
