import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/const.dart';
import '../../../httpbean/recommand.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../contact/load_state.dart';
import 'contact_follow_followed_page_controller.dart';

class Contact_follow_followed_pagePage extends StatefulWidget {
  int type;
  String userId;

  Contact_follow_followed_pagePage({this.type, this.userId});

  @override
  State<StatefulWidget> createState() {
    return Contact_follow_followedPageState();
  }
}

class Contact_follow_followedPageState
    extends State<Contact_follow_followed_pagePage> {
  Contact_follow_followed_pageController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(Contact_follow_followed_pageController(),
        tag: widget.type.toString());
    controller.initController(widget.type);
    controller.getData(refresh: RefreshState.first, userId: widget.userId);
  }

  _buildItem(BuildContext context, int index,
      Contact_follow_followed_pageController controller) {
    Recommand model = controller.jokes[index];

    String foller = model.followers.toString();
    String folling = model.following.toString();
    TextStyle styles = TextStyle(color: Colors.grey, fontSize: 14);

    return InkWell(
      onTap: () {
        // if (widget.type == 1) {
        //   Future(() {
        //     Navigator.of(context).push(new MaterialPageRoute(
        //         builder: (_) => new ContactsDetailsPage(
        //             sid: model.username.toString(),
        //             about: model.about,
        //             nickname: model.age,
        //             userid: model.id.toString(),
        //             avatar: model.avatar,
        //             title: model.name)));
        //   }).then((value) => setState(() {}));
        // } else {
        //   routePush(new ContactsDetailsPage(
        //       sid: model.username.toString(),
        //       about: model.about,
        //       nickname: model.age,
        //       userid: model.id.toString(),
        //       avatar: model.avatar,
        //       title: model.name));
        // }
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: model.avatar != ''
                      ? Image.network(model.avatar,
                          width: 60, height: 60, fit: BoxFit.cover)
                      : Image.asset(
                          'assets/images/wechat/in/default_nor_avatar.png'),
                ),
                Visibility(
                  visible: model.verified == "1",
                  child: Positioned(
                    child: Image.asset('assets/images/ic_pay.png'),
                    top: 2,
                    right: 2,
                  ),
                )
              ]),
              SizedBox(
                width: 15,
              ),
              Column(
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
                  Text(
                    model.about ?? '',
                    style: styles,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  '粉丝 $foller  关注 $folling',
                  style: styles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FlutterEasyLoading(
      child: new Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: widget.type == 1 ? '他的关注' : '他的粉丝'),
        body: Obx(() => SmartRefresher(
              // onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              enablePullDown: false,
              enablePullUp: true,
              controller: controller.refreshCon,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 1.0, color: Colors.grey),
                  itemCount: controller.jokes.length,
                  itemBuilder: (context, index) =>
                      _buildItem(context, index, controller)),
            )),
      ),
    );
  }
}
