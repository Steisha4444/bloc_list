import 'package:bloc_list/features/items/bloc/items_bloc.dart';
import 'package:bloc_list/features/items/ui/items_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'floating_buttons.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc()..add(ItemsFetchEvent(true)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Items Page'),
        ),
        body: ItemsView(),
        floatingActionButton: const FloatingButtons(),
      ),
    );
  }
}
