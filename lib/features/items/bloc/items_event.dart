part of 'items_bloc.dart';

abstract class ItemsEvent {}

class ItemsFetchEvent extends ItemsEvent {
  bool showLoader = true;
  ItemsFetchEvent(this.showLoader);
}

class ItemAddEvent extends ItemsEvent {}

class ItemDeleteEvent extends ItemsEvent {}
