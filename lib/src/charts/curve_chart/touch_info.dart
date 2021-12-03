// import 'package:flutter/material.dart';

// class TouchInfo extends ChangeNotifier {
//   final List<Offset> _points = [];
//   int _selectIndex = -1;

//   int get selectIndex => _selectIndex;

//   List<Offset> get points => _points;

//   set selectIndex(int value) {
//     assert(value != null);
//     if (_selectIndex == value) return;

//     _selectIndex = value;
//     notifyListeners();
//   }

//   void addPoint(Offset point) {
//     points.add(point);
//     notifyListeners();
//   }

//   void updatePoint(int index, Offset point) {
//     points[index] = point;
//     notifyListeners();
//   }

//   void reset() {
//     _points.clear();
//     _selectIndex = -1;
//     notifyListeners();
//   }

//   Offset? get selectPoint => _selectIndex == -1 ? null : _points[_selectIndex];
// }
