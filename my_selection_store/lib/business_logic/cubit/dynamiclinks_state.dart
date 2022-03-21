part of 'dynamiclinks_cubit.dart';

@immutable
abstract class DynamiclinksState {}

class DynamiclinksWaiting extends DynamiclinksState {}

class DynamicLinkReceived extends DynamiclinksState {
  final int productID;

  DynamicLinkReceived({required this.productID});
}
