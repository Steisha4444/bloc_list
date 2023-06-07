part of 'items_bloc.dart';

abstract class ItemsEvent {}

class ItemsFetchEvent extends ItemsEvent {}

class ItemAddEvent extends ItemsEvent {
  final Item item;
  ItemAddEvent(this.item);
}

class ItemDeleteEvent extends ItemsEvent {
  final Item item;
  ItemDeleteEvent(this.item);
}
