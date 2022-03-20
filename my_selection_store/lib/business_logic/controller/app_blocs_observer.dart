import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print("OnCreated> $bloc");
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print("OnClosed> $bloc");
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print("OnChanged> $bloc");
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print("OnEvent> $bloc");
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("OnTransitiont> $bloc");
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("OnError> $bloc");
    print(error);
    print(stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
