part of 'items_bloc.dart';

abstract class ItemsState {}

abstract class ItemsActionState extends ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsFetchingLoadingState extends ItemsState {}

class ItemsFetchingErrorState extends ItemsState {}

class ItemFetchingSuccessfulState extends ItemsState {
  final List<Item> items;
  ItemFetchingSuccessfulState({
    required this.items,
  });
}

class ItemsAdditionSuccessState extends ItemsActionState {}

class ItemsAdditionErrorState extends ItemsActionState {}

class ItemsDeletionSuccessState extends ItemsActionState {}

class ItemsDeletionErrorState extends ItemsActionState {}
