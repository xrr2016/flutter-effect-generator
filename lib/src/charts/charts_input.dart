import '../exports.dart';
import './charts_controller.dart';
import './models/data_item.dart';

class Item {
  Item({
    required this.headerValue,
    required this.list,
    this.isExpanded = false,
  });

  String headerValue;
  bool isExpanded;
  List<DataItem> list;
}

class ChartsInput extends StatefulWidget {
  final ChartsController controller;

  const ChartsInput({Key? key, required this.controller}) : super(key: key);

  @override
  _ChartsInputState createState() => _ChartsInputState();
}

class _ChartsInputState extends State<ChartsInput> {
  List<List<DataItem>> _datas = [];
  String _title = '';
  List<Item> _data = [];

  @override
  void initState() {
    _datas = widget.controller.datas;
    _title = widget.controller.title;
    _data = _generateItems(_datas.length);
    super.initState();
  }

  List<Item> _generateItems(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
      return Item(
        list: _datas[index],
        headerValue: '类别 ${index + 1}',
      );
    });
  }

  List<Widget> _buildInputs(int arrIndex, List<DataItem> list) {
    return List.generate(
      list.length,
      (index) {
        DataItem dataItem = list[index];
        TextEditingController nameCon = TextEditingController(
          text: dataItem.name,
        );
        TextEditingController valCon = TextEditingController(
          text: dataItem.value.toString(),
        );

        return Container(
          margin: EdgeInsets.only(top: 10.0),
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
                  decoration: InputDecoration(
                    counter: Container(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                flex: 6,
                child: TextField(
                  controller: valCon,
                  onChanged: (val) {
                    widget.controller.changeItemValue(
                      arrIndex,
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
                  decoration: InputDecoration(
                    counter: Container(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              _removeDataButton(arrIndex, index),
            ],
          ),
        );
      },
    );
  }

  Widget _addDataButton(int index) {
    return InkWell(
      onTap: () {
        widget.controller.addDataItem('text', 100.0);
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
                // BoxShadow(
                //   color: Color(0xffffffff),
                //   offset: Offset(-5.0, -5.0),
                //   blurRadius: 12,
                //   spreadRadius: 0.0,
                // ),
                // BoxShadow(
                //   color: Color(0xffd1d0d0),
                //   offset: Offset(5.0, 5.0),
                //   blurRadius: 12,
                //   spreadRadius: 0.0,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _removeDataButton(int addIndex, int dataIndex) {
    return SizedBox(
      width: 60.0,
      child: IconButton(
        onPressed: () {
          widget.controller.removeDataItem(addIndex, dataIndex);
          setState(() {});
        },
        icon: Icon(Icons.delete_outline_rounded),
      ),
    );
  }

  Widget _buildSections() {
    return ExpansionPanelList(
      elevation: 1.0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: List.generate(
        _data.length,
        (index) {
          Item item = _data[index];

          return ExpansionPanel(
            backgroundColor: Color(0xffefeeee),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(title: Text(item.headerValue));
            },
            body: Container(
              color: Color(0xffefeeee),
              child: Column(
                children: [
                  ..._buildInputs(index, item.list),
                  _addDataButton(index),
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      margin: EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: TextEditingController(
                text: _title,
              ),
              onChanged: (val) {
                widget.controller.changeChartTitle(val);
              },
            ),
          ),
          Expanded(
            child: ListView(
              controller: ScrollController(
                keepScrollOffset: true,
              ),
              children: [_buildSections()],
            ),
          ),
        ],
      ),
    );
  }
}
