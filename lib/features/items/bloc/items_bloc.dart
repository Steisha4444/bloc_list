import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_list/features/items/models/item_model.dart';
import 'package:bloc_list/features/items/repos/items_repository.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  List<Item> items = [];
  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsFetchEvent>(itemsFetchEvent);
    on<ItemAddEvent>(itemAddEvent);
    on<ItemDeleteEvent>(itemDeleteEvent);
  }

  FutureOr<void> itemsFetchEvent(
    ItemsFetchEvent event,
    Emitter<ItemsState> emit,
  ) async {
    try {
      if (event.showLoader) {
        emit(ItemsFetchingLoadingState());
      }
      items = await ItemsRepository.getItems();
      items.sort((a, b) => a.id.compareTo(b.id));
    } catch (e) {
      emit(ItemsFetchingErrorState());
    }

    emit(ItemFetchingSuccessfulState(items: items));
  }

  FutureOr<void> itemAddEvent(
      ItemAddEvent event, Emitter<ItemsState> emit) async {
    try {
      await ItemsRepository.addItem(
        Item(id: items.length, name: 'Items ${items.length}'),
      );
    } catch (e) {
      emit(ItemsAdditionErrorState());
    }

    emit(ItemsAdditionSuccessState());
    add(ItemsFetchEvent(false));
  }

  FutureOr<void> itemDeleteEvent(
      ItemDeleteEvent event, Emitter<ItemsState> emit) async {
    try {
      await ItemsRepository.deleteItem(items.last);
    } catch (e) {
      emit(ItemsDeletionErrorState());
    }
    emit(ItemsDeletionSuccessState());

    add(ItemsFetchEvent(false));
  }
}
