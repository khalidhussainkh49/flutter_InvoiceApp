// // StatelessWidget with UI for our ItemModel-s in ListView.
// import 'package:flutter/material.dart';
// import 'package:invoice_app/models/item_models.dart';
// import 'package:invoice_app/screens/item_details.dart';
// import 'package:invoice_app/utils/helpers.dart';

// class ItemWidget extends StatelessWidget {
//  const ItemWidget(this.model, this.onItemTap, {Key? key}) : super(key: key);

//  final ItemModel model;
//  final Function onItemTap;

//  @override
//  Widget build(BuildContext context) {
//    return InkWell( // Enables taps for child and add ripple effect when child widget is long pressed.
//      onTap: onItemTap,
//      child: ListTile( // Useful standard widget for displaying something in ListView.
//        leading: Icon(model.icon), 
//        title: Text(model.title),
//      ),
//    );
//  }
 
// }