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
      width: 320.0,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ElevatedButton.icon(
          //   onPressed: widget.controller.addDataItem,
          //   icon: Icon(Icons.add),
          //   label: Text('添加'),
          // ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: List.generate(
                widget.controller.datas.length,
                (index) {
                  DataItem dataItem = widget.controller.datas[index];
                  TextEditingController nameCon = TextEditingController(
                    text: dataItem.name,
                  );

                  return Container(
                    // color: Colors.amber,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: nameCon,
                            onChanged: (val) {
                              widget.controller.changeItemName(index, val);
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,

                            maxLines: 1,
                            maxLength: 5,
                            decoration: InputDecoration(counter: Container()),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(
                              text: dataItem.value.toString(),
                            ),
                            onChanged: (val) {
                              // widget.controller.changeItemValue(
                              //   index,
                              //   double.parse(val),
                              // );
                            },
                            maxLines: 1,
                            maxLength: 5,
                            // textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            textInputAction: TextInputAction.next,
                            // keyboardType: TextInputType.numberWithOptions(
                            //   signed: true,
                            //   decimal: false,
                            // ),
                            decoration: InputDecoration(counter: Container()),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        SizedBox(
                          width: 60.0,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete_outline_rounded),
                          ),
                        ),
                      ],
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
