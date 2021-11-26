import 'package:flutter/material.dart';

import 'utils.dart';
import 'sketch_canvas.dart';
import 'constants.dart';

class SketchView extends StatefulWidget {
  const SketchView({Key? key}) : super(key: key);

  @override
  State<SketchView> createState() => _SketchViewState();
}

class _SketchViewState extends State<SketchView> {
  int currentColorIndex = 0;
  Color currentColor = colors[0];

  _setCurrentColor(int index) {
    setState(() {
      currentColorIndex = index;
      currentColor = colors[currentColorIndex];
    });
  }

  double strokeWidth = 10.0;

  _setStrokeWidth(double val) {
    setState(() {
      strokeWidth = val;
    });
  }

  GlobalKey allPathKey = GlobalKey();

  List historys = [
    {'type': 'Clear'},
    {'type': 'Line'},
    {'type': 'Arc'},
    {'type': 'Line'},
    {'type': 'Ellipse'},
    {'type': 'Square'},
    {'type': 'Point'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return Container(
            color: Colors.amber[100],
            child: Row(
              children: [
                Container(
                  width: 120.0,
                  margin: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          setState(() {
                            currentColor = Colors.white;
                          });
                        },
                        child: Text('Clean'),
                      ),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Arc')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Circle')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Ellipse')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Line')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Point')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Triangle')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Quad')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Rect')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Square')),
                      Divider(),
                      OutlinedButton(onPressed: () {}, child: Text('Image')),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      // ValueListenableBuilder(
                      //   valueListenable:  null,
                      //   builder: (BuildContext context, dynamic value, Widget? child) {
                      //     return  Container();
                      //   },
                      // ),
                      Expanded(
                        child: SketchCanvas(
                          color: currentColor,
                          strokeWidth: strokeWidth,
                          allPathKey: allPathKey,
                        ),
                      ),
                      Container(
                        height: 60.0,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        margin: EdgeInsets.only(
                          left: 20.0,
                          bottom: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: AlwaysScrollableScrollPhysics(),
                                children: List.generate(
                                  colors.length,
                                  (int index) {
                                    bool active = currentColorIndex == index;

                                    return GestureDetector(
                                      onTap: () {
                                        _setCurrentColor(index);
                                      },
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: colors[index],
                                          border: active
                                              ? Border.all(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                )
                                              : null,
                                        ),
                                        margin: EdgeInsets.only(right: 10.0),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            SizedBox(
                              width: 300.0,
                              child: ListTile(
                                leading: Text('Width'),
                                title: Slider(
                                  min: 1.0,
                                  max: 20.0,
                                  value: strokeWidth,
                                  onChanged: _setStrokeWidth,
                                ),
                                trailing: Text(strokeWidth.toStringAsFixed(1)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100.0,
                  margin: EdgeInsets.only(top: 20.0, right: 20.0, bottom: 20.0),
                  // color: Colors.blueAccent,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              save(allPathKey);
                            },
                            icon: Icon(Icons.save_alt),
                          ),
                          IconButton(
                            onPressed: () {
                              // clear(canvas, size)
                            },
                            icon: Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: List.generate(
                            historys.length,
                            (index) => Text(historys[index]['type']),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
