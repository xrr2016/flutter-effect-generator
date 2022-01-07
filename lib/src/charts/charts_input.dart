import '../exports.dart';
import './colors.dart';
import './charts_controller.dart';
import './models/data_item.dart';

class Item {
  Item({
    required this.header,
    required this.list,
    this.isExpanded = false,
  });

  String header;
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
  String _title = '';
  List<Item> _datas = [];

  @override
  void initState() {
    _title = widget.controller.title;
    _datas = _generateItems();
    super.initState();
  }

  List<Item> _generateItems() {
    return List<Item>.generate(
      widget.controller.series.length,
      (int index) {
        return Item(
          list: widget.controller.series[index].data,
          header: widget.controller.series[index].name,
          isExpanded: false,
        );
      },
    );
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
          text: dataItem.value.toStringAsFixed(0),
        );

        return Container(
          margin: EdgeInsets.only(top: 4.0),
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
                  maxLength: 10,
                  style: TextStyle(fontSize: 12.0),
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
                  maxLength: 10,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: true,
                    decimal: false,
                  ),
                  style: TextStyle(fontSize: 12.0),
                  decoration: InputDecoration(
                    counter: Container(),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 0.5),
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
    return OutlinedButton(
      onPressed: () {
        widget.controller.addDataItem('text', 100.0);
        setState(() {});
      },
      child: Container(
        height: 40.0,
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _addDataListButton() {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: OutlinedButton(
        style: ButtonStyle(),
        onPressed: () {
          widget.controller.addDataList();
          _datas = _generateItems();
          setState(() {});
        },
        child: Text(
          '添加',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  Widget _removeDataButton(int addIndex, int dataIndex) {
    return SizedBox(
      width: 40.0,
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
          _datas[index].isExpanded = !isExpanded;
        });
      },
      children: List.generate(
        _datas.length,
        (index) {
          Item item = _datas[index];

          return ExpansionPanel(
            backgroundColor: Color(0xffefeeee),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.header),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline_rounded),
                  onPressed: () {
                    widget.controller.removeDataList(index);
                    _datas = _generateItems();
                    setState(() {});
                  },
                ),
              );
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

  TextField _editTitleInput() {
    return TextField(
      controller: TextEditingController(
        text: _title,
      ),
      onChanged: (val) {
        widget.controller.changeChartTitle(val);
      },
    );
  }

  List<InkWell> _buildThemeList() {
    return List.generate(
      themes.length,
      (int index) {
        List<Color> theme = themes[index];

        return InkWell(
          onTap: () {
            widget.controller.changeChartTheme(index);
          },
          child: Container(
            height: 22.0,
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(
              children: List.generate(
                theme.length,
                (index) {
                  return Expanded(
                    child: Container(color: theme[index]),
                  );
                },
              ),
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.0,
      margin: EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _editTitleInput(),
          SizedBox(height: 10.0),
          ..._buildThemeList(),
          _addDataListButton(),
          Expanded(
            child: ListView(
              controller: ScrollController(
                keepScrollOffset: true,
              ),
              children: [
                _buildSections(),
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
