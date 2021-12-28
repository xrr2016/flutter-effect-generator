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
  List<DataItem> _datas = [];

  @override
  void initState() {
    _datas = widget.controller.datas;
    super.initState();
  }

  List<Widget> _buildInputs() {
    return List.generate(
      _datas.length,
      (index) {
        DataItem dataItem = widget.controller.datas[index];
        TextEditingController nameCon = TextEditingController(
          text: dataItem.name,
        );
        TextEditingController valCon = TextEditingController(
          text: dataItem.value.toString(),
        );

        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  controller: nameCon,
                  onChanged: (val) {
                    widget.controller.changeItemName(index, val);
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  maxLength: 5,
                  decoration: InputDecoration(counter: Container()),
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                flex: 6,
                child: TextField(
                  controller: valCon,
                  onChanged: (val) {
                    widget.controller.changeItemValue(
                      index,
                      double.parse(val),
                    );
                  },
                  maxLines: 1,
                  maxLength: 5,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: true,
                    decimal: false,
                  ),
                  decoration: InputDecoration(counter: Container()),
                ),
              ),
              SizedBox(width: 12.0),
              _removeDataButton(index),
            ],
          ),
        );
      },
    );
  }

  Widget _addDataButton() {
    return InkWell(
      onTap: () {
        DataItem item = DataItem(name: 'text', value: 100.0);
        widget.controller.addDataItem(item);
        setState(() {});
      },
      child: Container(
        height: 50.0,
        color: Color(0xffefeeee),
        alignment: Alignment.center,
        child: Container(
          color: Color(0xffefeeee),
          child: Container(
            height: 60.0,
            alignment: Alignment.center,
            child: Text(
              '添加',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xffefeeee),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffefeeee),
                  Color(0xffefeeee),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffffffff),
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 12,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Color(0xffd1d0d0),
                  offset: Offset(5.0, 5.0),
                  blurRadius: 12,
                  spreadRadius: 0.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _removeDataButton(int index) {
    return SizedBox(
      width: 60.0,
      child: IconButton(
        onPressed: () {
          widget.controller.removeDataItem(index);
          setState(() {});
        },
        icon: Icon(Icons.delete_outline_rounded),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.0,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: [
                ..._buildInputs(),
                _addDataButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
