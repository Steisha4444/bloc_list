import 'package:bloc_list/features/items/bloc/items_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({
    super.key,
  });

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          mini: true,
          onPressed: () => removeItem(context),
          child: const Icon(Icons.remove),
        ),
        const SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          mini: true,
          onPressed: () => addItem(context),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
