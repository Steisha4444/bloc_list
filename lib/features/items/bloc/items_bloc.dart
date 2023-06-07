import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_list/features/items/models/item_model.dart';
import 'package:bloc_list/features/items/repos/items_repo.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsFetchEvent>(itemsFetchEvent);
    on<ItemAddEvent>(itemAddEvent);
    on<ItemDeleteEvent>(itemDeleteEvent);
  }

  FutureOr<void> itemsFetchEvent(
      ItemsFetchEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsFetchingLoadingState());
    List<Item> items = await ItemsRepo.getItems();

    emit(ItemFetchingSuccessfulState(items: items));
  }

  FutureOr<void> itemAddEvent(
      ItemAddEvent event, Emitter<ItemsState> emit) async {
    try {
      await ItemsRepo.addItem(event.item);
    } catch (e) {
      emit(ItemsAdditionErrorState());
    }

    emit(ItemsAdditionSuccessState());
  }

  FutureOr<void> itemDeleteEvent(
      ItemDeleteEvent event, Emitter<ItemsState> emit) async {
    try {
      await ItemsRepo.deleteItem(event.item);
    } catch (e) {
      emit(ItemsAdditionErrorState());
    }

    emit(ItemsAdditionSuccessState());
  }
}
