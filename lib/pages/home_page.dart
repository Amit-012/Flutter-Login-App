import 'package:demoapp/models/items_model.dart';
import 'package:demoapp/widgets/drawer.dart';
import 'package:demoapp/widgets/item_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final int days = 30;
  final String name = "Amit sharma";
  final dummyList = List.generate(50, (index) => CatalogModel.items[0]);
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: ListView.builder(
          itemCount: dummyList.length,
          itemBuilder: (context, index) {
            return ItemWidget(
              item: dummyList[index],
            );
          },
        ),
      ),
      drawer: const Mydrawer(),
    );
  }
}
