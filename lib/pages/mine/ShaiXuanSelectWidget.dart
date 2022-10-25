import 'package:flutter/material.dart';
class ShaiXuanSelectWidget extends StatefulWidget {
  final List PinpaiListData;
  ShaiXuanSelectWidget(
      {
         @required this.PinpaiListData,
    });
  @override
  ShaiXuanSelectWidgetState createState() => ShaiXuanSelectWidgetState();
}

class ShaiXuanSelectWidgetState extends State<ShaiXuanSelectWidget> {
  //品牌字典组
  List _pinpaiGroup = [];
  // 当前选中的品牌
  int _nowClickPinpai;

  // 分类选择组
  List _typeGroup = [];
  int _nowClickFenlei;
  // 系列选择组
  List _xilieGroup = [];
  int _nowClickXilie;
  // 当前选择系列的数据
  // List _nowChooseXilieGroup = [];
String _nowSelectedXilieSte = "";
  bool _isFirst = true;

  @override
  void initState() {
    super.initState();
    if (_isFirst) {
      initData();
      _isFirst = false;
    }
  }
  @override
  Widget build(BuildContext context) {

   return StatefulBuilder(
      builder: (BuildContext context, StateSetter modalSetState) {
        return Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: buildDeviceContainer(modalSetState),
              ),
              Expanded(
                flex: 0,
                child: buildBottomButton(modalSetState),
              ),
            ],
          ),
        );
      },
    );
  }

  // 初始化数据
  void initData() {
    _pinpaiGroup = ["中国","美国"];
    // whilePinpai(widget.PinpaiListData);
    whileBig(_pinpaiGroup);
    setState(() {});
  }
  void whileBig(data) {
    for (int i = 0; i < data.length; i++) {
      if (null != data[i]) {
        _pinpaiGroup
            .add({'name': data[i]["name"], 'city': data[i]["city"]});
      }
    }
  }
  // 格式化品牌组
  void whilePinpai(data) {
    for (int i = 0; i < data.length; i++) {
      if (null != data[i]) {
        _pinpaiGroup
            .add({'name': data[i].name, 'value': data[i].cid});
      }
    }
  }

  // 选择品牌
  buildDeviceContainer(StateSetter modalSetState) {
    return Row(
      children: <Widget>[
    Expanded(
    child: Column(
        children: <Widget>[
          Container(
            height: 20,
            child: Text('品牌',style: TextStyle(
              fontSize: 16,
            ),),
          ),
          Expanded(
            child: selectPinpaiItem(modalSetState),
          ),
        ])),

        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
                child: Text('分类', style: TextStyle(
                  fontSize: 16,
                ),),
              ),
              Expanded(
                child: selectTypeItem(modalSetState),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                      height: 20,
                      child: Text('系列',style: TextStyle(
                        fontSize: 16,
                      ),),
                    ),
              Expanded(
                child: selectXILieItem(modalSetState),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 底部操作按钮
  buildBottomButton(StateSetter modalSetState) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: Text('取消'),
            onPressed: () {
              modalSetState(() {
                _nowClickPinpai = null;
                _nowClickFenlei=null;
                _nowClickFenlei=null;
                _typeGroup = [];
                _xilieGroup = [];
                // _nowChooseXilieGroup = [];
                _nowSelectedXilieSte = "";
              });
            },
          ),
          RaisedButton(
            padding: EdgeInsets.all(0),
            color: Color.fromRGBO(
                253, 117, 80, 1),
            child: Text('确定',  textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),),
            onPressed: () {
              Navigator.pop(context, _nowSelectedXilieSte);
            },
          ),
        ],

    );
  }

  // 品牌列表
  selectPinpaiItem(StateSetter modalSetState) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 40,
          child: GestureDetector(
            child: ListTile(
              title: Text(
                  _pinpaiGroup.length > 0 ? _pinpaiGroup[index]['name'] ?? ' ' : '　',
                  maxLines: 1,
                  style: _nowClickPinpai == index
                      ? TextStyle(color:Color.fromRGBO(
                      253, 117, 80, 1), fontSize: 13,)
                      : TextStyle(fontSize: 13,color:Colors.black45)),
            ),
            onTap: () {
              if (_nowClickPinpai != index) {
              setState(() {
                _nowClickPinpai = index;
                whileType(_pinpaiGroup[index]);
              });
              }
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 0.0,
        );
      },
      itemCount: _pinpaiGroup.length,
    );

  }

  // 分类列表
  selectTypeItem(StateSetter modalSetState) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 40,
          child: GestureDetector(
            child: ListTile(
              title: Text(
                  _typeGroup.length > 0 ? _typeGroup[index]['name'] ?? ' ' : '　',
                  style: _nowClickFenlei==index
                      ? TextStyle(color: Color.fromRGBO(
                      253, 117, 80, 1), fontSize: 13,)
                      : TextStyle(fontSize: 13,color:Colors.black45)),
            ),
            onTap: () {
              if (_nowClickFenlei != index) {
                setState(() {
                  _nowClickFenlei = index;
                  whileXilie(_typeGroup[index]);
                });
              }
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 0.0,
        );
      },
      itemCount: _typeGroup.length,
    );
  }

  // 系列列表
  selectXILieItem(StateSetter modalSetState) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 40,
          child: GestureDetector(
            child: ListTile(
              title: Text(
                _xilieGroup.length > 0 ? _xilieGroup[index]['name'] ?? ' ' : '　',
                style: _nowClickXilie==index
                    ? TextStyle(color: Color.fromRGBO(
                    253, 117, 80, 1), fontSize: 13,)
                    : TextStyle(fontSize: 13,color:Colors.black45)),
              ),
            onTap: () {
              if (_nowClickXilie != index) {
                setState(() {
                  _nowClickXilie  = index;
                  _nowSelectedXilieSte =_xilieGroup[index]['name'];
                });
              }
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 0.0,
        );
      },
      itemCount: _xilieGroup.length,
    );
  }

// 获取分类名称
  whileType(dataMap) {
    _typeGroup=[];
    for (int i = 0; i < dataMap['city'].length; i++) {
      if (null != dataMap['city'][i]) {
          _typeGroup.add(
              {'name': dataMap['city'][i]['name'],'area': dataMap['city'][i]['area'], 'check': false});
      }
    }
  }

 // 获取系列
  whileXilie(areaMap) {
    _xilieGroup=[];
    for (int i = 0; i < areaMap['area'].length; i++) {
      if (null != areaMap['area'][i]) {
        _xilieGroup.add(
            {'name': areaMap['area'][i], 'check': false});
      }
    }
  }
}
