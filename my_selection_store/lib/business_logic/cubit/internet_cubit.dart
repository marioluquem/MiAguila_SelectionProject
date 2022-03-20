import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:my_selection_store/helpers/enums.dart';

part 'internetconnection_state.dart';

class InternetCubit extends Cubit<InternetconnectionState> {
  late Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity})
      : super(InternetconnectionInitial()) {
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
          emitInternetConnected(InternetConnectionType.wifi);
          break;
        case ConnectivityResult.mobile:
          emitInternetConnected(InternetConnectionType.mobile);
          break;
        case ConnectivityResult.none:
          emitInternetDisconnected();
          break;
        default:
          emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(InternetConnectionType connection) {
    emit(InternetConnected(connectionType: connection));
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  bool isConnectedToInternet() {
    return state is InternetConnected;
  }
}
