import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import '../../helpers/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetInitial()) {
    trackInternetConnection();
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  void trackInternetConnection() {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connection) {
      switch (connection) {
        case ConnectivityResult.wifi:
          emitInternetConnected(InternetType.wifi);
          break;
        case ConnectivityResult.mobile:
          emitInternetConnected(InternetType.mobile);
          break;
        case ConnectivityResult.none:
          emitInternetDisconnected();
          break;
        default:
          emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(InternetType connection) {
    emit(InternetConnected(connectionType: connection));
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  bool isConnectedToInternet() {
    return state is InternetConnected;
  }
}
