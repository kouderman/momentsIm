import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/pages/contact/person_view.dart';
import 'package:wechat_flutter/pages/wechat_friends/chat_style.dart';
import 'package:wechat_flutter/ui/view/text_view.dart';

import '../../../config/logger_util.dart';
import '../../../httpbean/recommand.dart';
import '../../../tools/wechat_flutter.dart';
import '../../../ui/chat/my_conversation_view.dart';
import '../../../ui/view/image_view.dart';
import '../../contacts/contacts_details_page.dart';
import '../../mine/areaevent.dart';
import '../../wechat_friends/friendcircle/friendcircle_view.dart';
import '../load_state.dart';
import 'childrecye_logic.dart';

class ChildrecyePage extends StatefulWidget {
  int type;

  ChildrecyePage({this.type});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChildrecyeState();
  }
}

class ChildrecyeState extends State<ChildrecyePage>
    with TickerProviderStateMixin {
  _buildItem(BuildContext context, int index, ChildrecyeLogic controller) {
    Recommand model = controller.jokes[index];

    String foller = model.followers.toString();
    String folling = model.following.toString();
    TextStyle styles = TextStyle(color: Colors.grey, fontSize: 12);

    return InkWell(
      onTap: () {
        if (widget.type == 1) {
          Future(() {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) => new ContactsDetailsPage(
                    sid: model.username.toString(),
                    about: model.about,
                    nickname: model.age,
                    userid: model.id.toString(),
                    avatar: model.avatar,
                    title: model.name)));
          }).then((value) => setState(() {}));
        } else {
          routePush(new ContactsDetailsPage(
              sid: model.username.toString(),
              about: model.about,
              nickname: model.age,
              userid: model.id.toString(),
              avatar: model.avatar,
              title: model.name));
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 0, top: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  Padding(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // 背景色
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        // border: new Border(
                        // top: BorderSide(
                        //     color: Colors.white, width: 0.2)), // border
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)), // 圆角
                      ),
                      child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white, // 背景色
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                  // border: new Border(
                                  // top: BorderSide(
                                  //     color: Colors.white, width: 0.2)), // border
                                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)), // 圆角
                                ),
                              ),
                          imageUrl: model.avatar ?? default_avatar,
                          width: winWidth(context),
                          height: (winWidth(context) - 30) / 2,
                          fit: BoxFit.cover),
                    ),
                    padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  ),

                  // ClipRRect(
                  //   child: model.avatar != ''
                  //       ? Image.network(model.avatar,
                  //           width: winWidth(context),
                  //           height: 190,
                  //           fit: BoxFit.cover)
                  //       : Image.asset(
                  //           'assets/images/wechat/in/default_nor_avatar.png'),
                  // ),
                  Visibility(
                    visible: model.verified == "1",
                    child: Positioned(
                      child: Image.asset(
                        'assets/images/mine/ic_pay.png',
                        width: 20,
                        height: 20,
                      ),
                      top: 0,
                      right: 0,
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 0,
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  color: appBarColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            color:
                                model.verified == "1" ? greenColor : titleColor,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
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
                                width: 10,
                                height: 10,
                                child: model.gender == "M"
                                    ? Image.asset('assets/images/M1_1.png')
                                    : Image.asset('assets/images/F1_1.png')),
                            Text(
                              model.age,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      // Text(model.username ?? '',style: styles,),
                    ],
                  ),
                ),
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
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  color: appBarColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: appBarColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 0, bottom: 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            model.province + '' + model.city,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: styles,
                          ),
                        ),
                        // Expanded(child: SizedBox()),
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/location.png',
                                width: 10,
                                height: 10,
                              ),
                              Text(
                                model.distance ,
                                maxLines: 1,
                                style: styles,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ChildrecyeLogic controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChildrecyeLogic(), tag: widget.type.toString());
    controller.initController(widget.type);
    controller.getData(refresh: RefreshState.first);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LoggerUtil.i("build--------------", tag: widget.type);

    return FlutterEasyLoading(
      child: Obx(() => Stack(
            children: [
              SmartRefresher(
                // onRefresh: controller.onRefresh,
                onLoading: controller.onLoading,
                enablePullDown: false,
                enablePullUp: controller.jokes.length==0?false:true,
                controller: controller.refreshCon,
                child: GridView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //设置列数
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 5,
                      //设置横向间距
                      crossAxisSpacing: 10,
                      //设置主轴间距
                      mainAxisSpacing: 10,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.jokes.length,
                    itemBuilder: (context, index) =>
                        _buildItem(context, index, controller)),
              ),
              Visibility(
                  visible: controller.jokes.length == 0,
                  child: Center(
                    child: widget.type==1?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('您还没有关注任何人!',style: TextStyle(color: subtitleColor,fontSize: 12),),
                        Text('赶快去关注感兴趣的小伙伴吧',style: TextStyle(color: subtitleColor,fontSize: 12),),
                        SizedBox(height: 10,),
                        GestureDetector(
                        onTap: (){
                          routePush(new FriendcirclePage(
                              "1",
                              "",
                              "iamkefu",
                              "iamkefu"));
                        }
                        ,child: new Image.asset('assets/images/guanzhu.png')),
                      ],
                    ):Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('很遗憾,您还没有粉丝哟!',style: TextStyle(color: subtitleColor,fontSize: 12),),
                        SizedBox(height: 10,),
                        GestureDetector(
                            onTap: (){
                              routePush(new FriendcirclePage(
                                  "1",
                                  "",
                                  "iamkefu",
                                  "iamkefu"));
                            }
                            ,child: new Image.asset('assets/images/fensi.png')),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
