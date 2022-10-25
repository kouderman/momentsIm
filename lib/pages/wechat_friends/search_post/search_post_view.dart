import 'package:dim/commom/check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/httpbean/resppost.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../httpbean/post.dart';
import '../../../httpbean/respsearchposts.dart';
import '../../../httpbean/searchitempost.dart';
import '../../../tools/sp_util.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/button/commom_button.dart';
import '../ui/item_dynamic.dart';
import 'search_post_controller.dart';

class Search_postPage extends StatefulWidget {




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchPageState();
  }
}
class SearchPageState extends State<Search_postPage> {
  TextEditingController _searchC = new TextEditingController();
  List<Post> list = [];

  Widget body() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1.0, color: Colors.grey),
        itemCount: list.length,
        itemBuilder: (context, index) => ItemDynamic(
          list[index],
          likeCallBack: (postId) {
            // likePost(postId);
          },
          deleteCallBack: (postId) {
            // deletePost(postId);
          },
        ));
  }

  void search() {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/search_posts', data: {
      "query": _searchC.text,
      "session_id": authToken,
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
          Respsearchposts respcountry = Respsearchposts.fromJson(data);
          list.clear();
          if (respcountry.data != null) {
            respcountry.data.forEach((element) {
              Post p = Post.fromJson(element.toJson());
              list.add(p);
              setState(() {});
            });
          }
        } else {}
      }
    });
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
              hintText: '请输入说说进行搜索',
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
      body: new SizedBox(width: double.infinity, child: body()),
    );
  }

}