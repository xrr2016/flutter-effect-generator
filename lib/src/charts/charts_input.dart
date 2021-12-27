import 'package:flutter_effect_generator/src/charts/models/data_item.dart';

import '../exports.dart';
import './charts_controller.dart';

class ChartsInput extends StatefulWidget {
  final ChartsController controller;

  const ChartsInput({Key? key, required this.controller}) : super(key: key);

  @override
  _ChartsInputState createState() => _ChartsInputState();
}

class _ChartsInputState extends State<ChartsInput> {
  Widget _buildListTile(
    String leading,
    double min,
    double max,
    double value,
    String trailing,
    Function(double) onChanged,
  ) {
    return ListTile(
      leading: Text(
        leading,
        style: const TextStyle(color: Colors.black),
      ),
      title: Slider(
        min: min,
        max: max,
        value: value,
        label: value.toString(),
        activeColor: Colors.amber,
        inactiveColor: Colors.white70,
        onChanged: onChanged,
      ),
      trailing: Text(
        trailing,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      color: Color(0xffefeeee),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: widget.controller.addDataItem,
            icon: Icon(Icons.add),
            label: Text('添加'),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: List.generate(
                widget.controller.datas.length,
                (index) {
                  DataItem dataItem = widget.controller.datas[index];

                  return ListTile(
                    leading: Text(
                      dataItem.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    title: Slider(
                      min: 0.0,
                      max: 1000.0,
                      value: dataItem.value,
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.white70,
                      onChanged: (double val) {
                        widget.controller.changeItemValue(index, val);
                      },
                    ),
                    trailing: Text(
                      dataItem.value.toStringAsFixed(0),
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
