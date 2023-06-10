import 'package:flutter/material.dart';
import 'package:bloc_list/features/items/models/item_model.dart';

class ItemsLogoList extends StatelessWidget {
  final bool showScrollbar;
  final double imageHeight;
  final double itemHeight;
  final int length;
  final List<Item> items;

  const ItemsLogoList({
    super.key,
    required this.showScrollbar,
    required this.imageHeight,
    required this.itemHeight,
    required this.length,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 6,
      thumbVisibility: showScrollbar,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: imageHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: length,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: itemHeight,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(8),
                  child: Text(items[index].name),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
