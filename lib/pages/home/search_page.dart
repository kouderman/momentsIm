import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wechat_flutter/config/logger_util.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../config/appdata.dart';
import '../../http/Method.dart';
import '../../http/resprecommand.dart';
import '../../httpbean/recommand.dart';
import '../../httpbean/respitemsearchpeople.dart';
import '../../httpbean/respsearchpeople.dart';
import '../../tools/sp_util.dart';
import '../contacts/contacts_details_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchC = new TextEditingController();

  void search() {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/search_people', data: {
      "query": _searchC.text,
      "session_id": authToken,
      "lat": SpUtil.getDouble("latitude"),
      "lng": SpUtil.getDouble("longitude"),
      "license": AppData.licence,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Resprecommand respcountry = Resprecommand.fromJson(data);
          list.clear();
          if (respcountry.data != null) {
            respcountry.data.forEach((element) {
              list.add(Recommand(
                  about: element.about,
                  avatar: element.avatar,
                  name: element.name,
                  id: element.id,
                  username: element.username ?? "",
                  followers: element.followers,
                  following: element.following.toString(),
                  city: element.city,
                  province: element.province,
                  distance: element.distance.toString(),
                  age: element.age.toString(),
                  verified: element.verified,
                  gender: element.gender));
            });
            setState(() {

            });
          }
        } else {}
      }
    });
  }

  @override
  void initState() {}

  List<Recommand> list = [];

  List words = ['朋友圈', '文章', '公众号', '小程序', '音乐', '表情'];

  Widget wordView(item) {
    return new InkWell(
      child: new Container(
        width: winWidth(context) / 3,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 15.0),
        child: new Text(
          item,
          style: TextStyle(color: tipColor),
        ),
      ),
      onTap: () => showToast(context, '$item功能小编正在开发'),
    );
  }

  _buildItem(BuildContext context, int index) {
    Recommand model = list[index];

    // String foller = model.followers.toString();
    // String folling = model.following.toString();
    TextStyle styles = TextStyle(color: Colors.grey, fontSize: 14);

    return InkWell(
      onTap: () {
        LoggerUtil.e(model);
        routePush(new ContactsDetailsPage(
            sid: model.name.toString(),
            about: model.about,
            nickname: model.age.toString(),
            userid: model.id.toString(),
            avatar: model.avatar,
            title: model.name));
      },
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: model.avatar != ''
                        ? Image.network(model.avatar,
                            width: winWidth(context),
                            height: 200,
                            fit: BoxFit.cover)
                        : Image.asset(
                            'assets/images/wechat/in/default_nor_avatar.png'),
                  ),
                  Visibility(
                    visible: model.verified == "1",
                    child: Positioned(
                      child: Image.asset(
                        'assets/images/mine/ic_pay.png',
                        width: 20,
                        height: 20,
                      ),
                      top: 2,
                      right: 2,
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: model.gender == "F"
                            ? AssetImage('assets/images/F1.png')
                            : AssetImage('assets/images/M1.png'),
                        // fit: BoxFit.fill, // 完全填充
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            child: model.gender == "M"
                                ? Image.asset('assets/images/M1_1.png')
                                : Image.asset('assets/images/F1_1.png')),
                        Text(
                          model.age,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  // Text(model.username ?? '',style: styles,),
                ],
              ),
              // SizedBox(
              //   width: 20,
              // ),
              // Expanded(
              //   child: Text(
              //     '粉丝 $foller  关注 $folling',
              //     style: styles,
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.province + '' + model.city,
                      overflow: TextOverflow.ellipsis,
                      style: styles,
                    ),
                    Text(
                      model.distance ,
                      style: styles,
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          //设置横向间距
          crossAxisSpacing: 10,
          //设置主轴间距
          mainAxisSpacing: 30,
        ),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) => _buildItem(context, index));
  }

  @override
  Widget build(BuildContext context) {
    var searchView = new Row(
      children: <Widget>[
        new Expanded(
          child: new TextField(
            textInputAction: TextInputAction.search,
            controller: _searchC,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入用户名搜索',
            ),
            onChanged: (text) {
              // setState(() {});
            },
          ),
        ),
        strNoEmpty(_searchC.text)
            ? new InkWell(
                child: new Image.asset('assets/images/ic_delete.webp'),
                onTap: () {
                  _searchC.text = '';
                  setState(() {});
                },
              )
            : new Container()
      ],
    );
    return new Scaffold(
      backgroundColor: appBarColor,
      appBar: new ComMomBar(
        titleW: searchView,
        rightDMActions: <Widget>[
          new ComMomButton(
            text: '搜索',
            style: TextStyle(color: Colors.white),
            width: 55.0,
            margin: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
            radius: 4.0,
            onTap: search,
          ),
        ],
      ),
      body: new SizedBox(width: winWidth(context), child: body()),
    );
  }
}
