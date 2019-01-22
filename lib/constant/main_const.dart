import 'package:flutter/material.dart';

const BOTTOM_TITLES = ["เปลี่ยนอะไหล่ซ่อม", 'อะไหล่'];
const BOTTOM_ICONS = [Icons.add, Icons.add];
const BAR_ICONS = [
  Icons.filter_1,
  Icons.filter_2,
];
const BAR_BACK_COLORS = [
  Colors.green,
  Colors.blueAccent,
];

enum ItemType {
  addPart,
  addStore,
}

ItemType convertItemType(index) {
  switch (index) {
    case 0:
      return ItemType.addPart;
    case 1:
      return ItemType.addStore;

    default:
      return ItemType.addPart;
  }
}
