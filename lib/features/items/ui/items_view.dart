import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_list/features/items/bloc/items_bloc.dart';
import 'package:bloc_list/features/items/ui/items_logo_list.dart';

class ItemsView extends StatelessWidget {
  ItemsView({
    Key? key,
  }) : super(key: key);

  final double itemHeight = 70;
  final double imageMinHeight = 150;
  bool showScrollbar = false;
  late double imageHeight;

  void handleImageHeight(int rows, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double calculatedHeight =
        screenHeight - (rows * itemHeight) - imageMinHeight;
    if (calculatedHeight > imageMinHeight) {
      imageHeight = calculatedHeight;
      showScrollbar = false;
    } else {
      imageHeight = imageMinHeight;
      showScrollbar = true;
    }
  }

  void removeItem(BuildContext context) {
    final bloc = context.read<ItemsBloc>();

    bloc.add(
      ItemDeleteEvent(),
    );
  }

  void addItem(BuildContext context) {
    final bloc = context.read<ItemsBloc>();

    bloc.add(
      ItemAddEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ItemsBloc>();
    return BlocConsumer<ItemsBloc, ItemsState>(
      bloc: bloc,
      listenWhen: (previous, current) => current is ItemsActionState,
      buildWhen: (previous, current) => current is! ItemsActionState,
      listener: (context, state) {
        if (state is ItemsAdditionErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'There was an error while adding data',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        if (state is ItemsDeletionErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'There was an error while removing data',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ItemsFetchingLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsFetchingErrorState) {
          return const Center(
            child: Text(
              'There was an error while fetching data',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        } else if (state is ItemFetchingSuccessfulState) {
          int rowCount = (state.items.length / 2).round();
          handleImageHeight(rowCount, context);
          return ItemsLogoList(
            showScrollbar: showScrollbar,
            imageHeight: imageHeight,
            itemHeight: itemHeight,
            length: state.items.length,
            items: state.items,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
