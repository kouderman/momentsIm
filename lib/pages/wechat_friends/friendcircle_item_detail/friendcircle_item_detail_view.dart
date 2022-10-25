import 'package:dim/commom/check.dart';
import 'package:dim/commom/ui.dart';
import 'package:dim/commom/win_media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/ui.dart';

import '../../../callback/callback.dart';
import '../../../config/const.dart';
import '../../../httpbean/post.dart';
import '../../../main.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/button/commom_button.dart';
import '../../../ui/dialog/confirm_alert.dart';
import '../../../ui/view/edit_view.dart';
import '../ui/item_dynamic.dart';
import '../ui/load_view.dart';
import 'friendcircle_item_detail_controller.dart';
import 'item_detail_input.dart';

class Friendcircle_item_detailPage extends StatefulWidget {
  final Post dynamic;

  Friendcircle_item_detailPage(this.dynamic, this.likeCallBack);

  final LikeCallBack likeCallBack;

  String def =
      'https://c-ssl.duitang.com/uploads/item/201803/04/20180304085215_WGFx8.thumb.700_0.jpeg';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailState();
  }
}

class DetailState extends State<Friendcircle_item_detailPage> {
  Friendcircle_item_detailController controller;
  TextEditingController _searchC = new TextEditingController();



  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => Friendcircle_item_detailController());
    controller = Get.find<Friendcircle_item_detailController>();
    controller.getLikes(widget.dynamic.id.toString());
    controller.getreplys(widget.dynamic.id.toString());

    controller.isLike.value = widget.dynamic.hasLiked;
  }

  _buildLickList() {
    List<Widget> list = [];
    list.add(Container(
      // width: 20,
      // height: 20,
      child: GestureDetector(
        onTap: () {
          controller.likePost(widget.dynamic.id.toString());
        },
        child: controller.isLike.value
            ? new Image.asset(
                'assets/images/likecc.png',
                width: 14,
                height: 14,
              )
            : new Image.asset(
                'assets/images/likec.png',
                width: 14,
                height: 14,
              ),
      ),
    ));
    if (controller.list.length > 0) {
      controller.list.forEach((element) {
        list.add(ImageLoadView(
          element.avatar,
          width: 20,
          height: 20,
        ));
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    int imageSize = 0;
    if (this.widget.dynamic.type == "image") {
      imageSize = this.widget.dynamic.media.length;
    }
    double imageWidth = (winWidth(context) - 20 - 50 - 10) /
        ((imageSize == 3 || imageSize > 4)
            ? 3.0
            : (imageSize == 2 || imageSize == 4)
                ? 2.0
                : 1.5);

    double videoWidth = (winWidth(context) - 20 - 50 - 10) / 2.2;

    BuildContext c = context;

    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '详情',),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ImageLoadView(
                      this.widget.dynamic.owner.avatar, //头像
                      height: 50,
                      width: 50,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 10.0, top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// 发布者昵称
                                Text(
                                  '${this.widget.dynamic.owner.name}',
                                  style: TextStyle(color: postNameColor),
                                ),

                                /// 发布的文字描述
                                Offstage(
                                    offstage: this.widget.dynamic.text.isEmpty,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text(this.widget.dynamic.text,
                                            style: TextStyle(color: titleColor),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis))),

                                /// 图片区域
                                Visibility(
                                    visible:
                                        this.widget.dynamic.type == "image",
                                    child: imageSize > 1
                                        ? GridView.builder(
                                            padding: EdgeInsets.only(top: 8.0),
                                            itemCount: imageSize,
                                            shrinkWrap: true,
                                            primary: false,
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent:
                                                        imageWidth,
                                                    crossAxisSpacing: 2.0,
                                                    mainAxisSpacing: 2.0,
                                                    childAspectRatio: 1),
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                                  onTap: () {
                                                    // showBigDialog(c,
                                                    //     this.dynamic.media[index].src);
                                                  },
                                                  child: ImageLoadView(
                                                    this
                                                        .widget
                                                        .dynamic
                                                        .media[index]
                                                        .x
                                                        .imageThumb,
                                                    fit: BoxFit.cover,
                                                    width: imageWidth,
                                                    height: imageWidth,
                                                  ),
                                                ))
                                        : imageSize == 1
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // showBigDialog(
                                                    //     c, this.dynamic.media[0].src);
                                                  },
                                                  child: ImageLoadView(
                                                    this
                                                        .widget
                                                        .dynamic
                                                        ?.media[0]
                                                        .x
                                                        .imageThumb,
                                                    width: imageWidth,
                                                    height: imageWidth,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ))
                                            : SizedBox()),

                                /// 视频区域
                                Visibility(
                                    visible:
                                        this.widget.dynamic.type == "video",
                                    child: Container(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            ImageLoadView(
                                              this.widget.dynamic.media.length >
                                                      0
                                                  ? this
                                                      .widget
                                                      .dynamic
                                                      .media[0]
                                                      .x
                                                      .poster_thumb
                                                  : this.widget.def,
                                              height: 200,
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.play_arrow,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  // routePush(VideoApp(
                                                  //     src: this.dynamic.media[0].src));
                                                })
                                          ],
                                        ),
                                        width: videoWidth)),

                                /// 定位地址
                                Visibility(
                                    visible: imageSize % 2 == 0,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text(
                                            '${this.widget.dynamic.area}',
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 13)))),

                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: saycolor,
                                  ),
                                  child: Visibility(
                                      visible: true,
                                      child: Obx(() => Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            children: _buildLickList(),
                                          ))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => Container(
                                    padding: EdgeInsets.all(8),
                                    height: controller.listReply.length >= 1
                                        ? 100
                                        : 0,
                                    decoration: BoxDecoration(
                                      color: saycolor,
                                    ),
                                    child: Obx(
                                      () => Visibility(
                                        visible:
                                            controller.listReply.length >= 1,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            new Image.asset(
                                              'assets/images/say.png',
                                              width: 12,
                                              height: 12,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Obx(
                                                () => ListView.builder(
                                                    itemCount: controller
                                                        .listReply.length,
                                                    // physics: NeverScrollableScrollPhysics(),
                                                    // shrinkWrap: true,
                                                    // primary: false,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            GestureDetector(
                                                              onLongPress: () {
                                                                if (controller
                                                                    .listReply[
                                                                        index]
                                                                    .canDelete) {
                                                                  confirmAlert(
                                                                    context,
                                                                    (isOK) {
                                                                      if (isOK) {
                                                                        controller.deletereply(
                                                                            context,
                                                                            controller.listReply[index].id.toString());
                                                                        ;
                                                                      }
                                                                      ;
                                                                    },
                                                                    tips:
                                                                        '确定删除该条评论吗？',
                                                                    okBtn: '确定',
                                                                  );
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Image.network(
                                                                    controller
                                                                        .listReply[
                                                                            index]
                                                                        .owner
                                                                        .avatar,
                                                                    width: 20,
                                                                    height: 20,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          controller
                                                                              .listReply[index]
                                                                              .owner
                                                                              .name,
                                                                          style: TextStyle(
                                                                              color: postNameColor,
                                                                              fontSize: 10),
                                                                        ),
                                                                        Text(
                                                                            controller.listReply[index].text,
                                                                            style: TextStyle(color: postContentColor, fontSize: 12)),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                /// 发布时间
                                Row(
                                    children: <Widget>[
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text('${this.widget.dynamic.time}',
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 12)),
                                            Visibility(
                                                visible: this
                                                    .widget
                                                    .dynamic
                                                    .canDelete,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller.deletepost(
                                                            c,
                                                            widget.dynamic.id
                                                                .toString());
                                                      },
                                                      child: Text('删除',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .blueAccent)),
                                                    )))
                                          ]),
                                      // TestPush(this.widget.dynamic,
                                      //     this.widget.likeCallBack),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween),

                                /// 评论部分
                              ])),
                    )
                  ],
                ),
                Container(
                    height: 0.5,
                    color: Colors.grey[200],
                    margin: EdgeInsets.only(top: 10))
              ]),
              Positioned(
                left: 10,
                right: 0,
                bottom: 12,
                child: Visibility(
                  visible: true,
                  child: Row(
                    children: [
                      Expanded(
                        child: new TextField(
                          style:
                              TextStyle(textBaseline: TextBaseline.alphabetic),
                          controller: _searchC,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '说点什么吧...' ?? '',
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/smile.png',
                        width: 20,
                        height: 20,
                      ),
                      Space(),
                      ComMomButton(
                        text: '发送',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        height: 30,
                        width: 40.0,
                        margin: EdgeInsets.only(
                            right: 6.0, top: 10.0, bottom: 10.0),
                        radius: 4.0,
                        onTap: () {
                          submit(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    controller.reply(context, widget.dynamic.id.toString(), _searchC.text);
  }
}
