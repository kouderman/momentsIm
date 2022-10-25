import 'package:wechat_flutter/callback/callback.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/httpbean/post.dart';
import 'package:wechat_flutter/pages/circleindex/tabcircle_view/tab_circle_person_info.dart';
import 'package:wechat_flutter/pages/wechat_friends/from.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart' as prefix1;
import 'package:wechat_flutter/ui/w_pop/friend_pop.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:flutter/material.dart' as prefix0;

import '../../contacts/contacts_details_page.dart';
import '../../pageview/pic_page.dart';
import '../../wechat_friends/friendcircle/video_play.dart';
import '../../wechat_friends/friendcircle_item_detail/friendcircle_item_detail_view.dart';
import '../../wechat_friends/ui/load_view.dart';

class CircleItemDetail extends StatelessWidget {
  final Post dynamic;
  final DeleteCallBack deleteCallBack;
  final LikeCallBack likeCallBack;

  CircleItemDetail(this.dynamic,
      {Key key, this.deleteCallBack, this.likeCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mType = this.dynamic.type;
    int imageSize = 0;
    if (mType == "image") {
      imageSize = this.dynamic.media.length;
    }
    // LoggerUtil.e("imagesize $imageSize");

    BuildContext c = context;
    double imageWidth = (winWidth(context) - 20 - 50 - 10) /
        ((imageSize == 3 || imageSize > 4)
            ? 3.0
            : (imageSize == 2 || imageSize == 4)
                ? 2.0
                : 1.5);

    double videoWidth = (winWidth(context) - 20 - 50 - 10) / 2.2;

    String desc = this.dynamic.text;

    String def =
        'https://c-ssl.duitang.com/uploads/item/201803/04/20180304085215_WGFx8.thumb.700_0.jpeg';

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('click');
                  routePush(new TabContactsDetailsPage(
                      userid: dynamic.userId.toString()));
                },
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: dynamic.owner.avatar != ''
                          ? Image.network(dynamic.owner.avatar,
                              width: 50, height: 50, fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/wechat/in/default_nor_avatar.png'),
                    ),
                  ),
                  Visibility(
                    visible: dynamic.owner.verified == "1",
                    child: Positioned(
                      child: Image.asset(
                        'assets/images/mine/ic_pay.png',
                        width: 15,
                        height: 15,
                      ),
                      top: 0,
                      right: 0,
                    ),
                  )
                ]),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    routePush(
                        Friendcircle_item_detailPage(dynamic, likeCallBack));
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 10.0, top: 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// 发布者昵称
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dynamic.owner.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: dynamic.owner.verified == "1"
                                          ? greenColor
                                          : postNameColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: dynamic.owner.gender == "F"
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
                                          child: dynamic.owner.gender == "M"
                                              ? Image.asset(
                                                  'assets/images/M1_1.png')
                                              : Image.asset(
                                                  'assets/images/F1_1.png')),
                                      Text(
                                        dynamic.owner.age.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9),
                                      )
                                    ],
                                  ),
                                ),
                                // Text(model.username ?? '',style: styles,),
                              ],
                            ),

                            /// 发布的文字描述
                            Offstage(
                                offstage: desc.isEmpty,
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text('$desc',
                                        style: TextStyle(
                                            color: postContentColor,
                                            fontSize: 14),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis))),

                            /// 图片区域
                            Visibility(
                                visible: mType == "image",
                                child: imageSize > 1
                                    ? GridView.builder(
                                        padding: EdgeInsets.only(top: 8.0),
                                        itemCount: imageSize,
                                        shrinkWrap: true,
                                        primary: false,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: imageWidth,
                                                crossAxisSpacing: 2.0,
                                                mainAxisSpacing: 2.0,
                                                childAspectRatio: 1),
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                              onTap: () {
                                                // showBigDialog(
                                                //     c,
                                                //     this
                                                //         .dynamic
                                                //         .media[index]
                                                //         .src);
                                                List<String> list = [];
                                                this.dynamic.media.forEach((element) {
                                                  list.add(element.src);
                                                });
                                                routePush(PicPage(list));
                                              },
                                              child: ImageLoadView(
                                                this
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
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                List<String> list = [];
                                                this.dynamic.media.forEach((element) {
                                                  list.add(element.src);
                                                });
                                                routePush(PicPage(list));
                                              },
                                              child: ImageLoadView(
                                                this
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

                            SizedBox(height: 15,),
                            Visibility(
                                visible: mType == "video",
                                child: Container(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        ImageLoadView(
                                          this.dynamic.media.length > 0
                                              ? this
                                                  .dynamic
                                                  .media[0]
                                                  .x
                                                  .poster_thumb
                                              : def,
                                          height: 200,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.play_arrow,
                                                color: Colors.white),
                                            onPressed: () {
                                              routePush(VideoApp(
                                                  src: this
                                                      .dynamic
                                                      .media[0]
                                                      .src));
                                            })
                                      ],
                                    ),
                                    width: videoWidth)),

                            /// 定位地址
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                    visible: true,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 0.0),
                                        child: Container(
                                          child: Text('${this.dynamic.area}',
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                  color: postareaColor,
                                                  fontSize: 12)),
                                        ))),
                                // Expanded(child: Text('')),
                                Row(
                                  children: [
                                    Visibility(
                                        visible:
                                        this.dynamic.likesCount != "0",
                                        child: Row(
                                          children: [
                                            Text(
                                              this.dynamic.likesCount + "",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: postareaColor),
                                            ),
                                            SizedBox(width: 4,),
                                            Container(
                                              child: new Image.asset(
                                                'assets/images/likec.png',width: 12,height: 12,),
                                            ),
                                          ],
                                        )),
                                    SizedBox(width: 10,),
                                    Visibility(
                                        visible:
                                        this.dynamic.replysCount != "0",
                                        child: Row(
                                          children: [
                                            Text(
                                              this.dynamic.replysCount + "",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: postareaColor),
                                            ),
                                            SizedBox(width: 4,),
                                            Container(
                                              // width: 20,
                                              // height: 20,
                                              child: new Image.asset(
                                                'assets/images/say.png',width: 12,height: 12,),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),

                            // Visibility(child: TextField(),),

                            /// 发布时间
                            Row(
                                children: <Widget>[
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('${this.dynamic.time}',
                                            style: TextStyle(
                                                color: postareaColor,
                                                fontSize: 10)),
                                        Visibility(
                                            visible: false,
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    deleteCallBack(this
                                                        .dynamic
                                                        .id
                                                        .toString());
                                                  },
                                                  child: Text('删除',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              postNameColor)),
                                                )))
                                      ]),
                                  Visibility(
                                    visible: false,
                                    child: TestPush(this.dynamic.id.toString(),
                                        this.likeCallBack),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween),

                            /// 评论部分
                          ])),
                ),
              )
              // GestureDetector(
              //   onTap: () {
              //     routePush(
              //         Friendcircle_item_detailPage(dynamic, likeCallBack));
              //   },
              //   child: ,
            ],
          ),
          Container(
              height: 0.5,
              color: Colors.grey[200],
              margin: EdgeInsets.only(top: 10))
        ]),
      ),
    );
  }

  void showBigDialog(BuildContext c, String src) {
    showDialog(
      context: c,
      builder: (ctx) {
        return GestureDetector(
          onTap: () {
            Navigator.of(c).pop();
          },
          child: Center(
            child: ImageLoadView(
              src,
              width: winWidth(c) - 0,
              height: winHeight(c) - 0,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class TestPush extends StatefulWidget {
  TestPush(this.postId, this.likeCallBack);

  String postId;
  LikeCallBack likeCallBack;

  @override
  _TestPushState createState() => _TestPushState();
}

class _TestPushState extends State<TestPush> {
  Widget _buildExit() {
    TextStyle labelStyle = TextStyle(color: Colors.white);
    return Container(
      width: 200,
      height: 36,
      decoration: BoxDecoration(
        color: itemBgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextButton(
              onPressed: () {
                widget.likeCallBack(widget.postId);
              },
              child: new Text('赞', style: labelStyle),
            ),
          ),
          new Expanded(
            child: new TextButton(
              onPressed: () {},
              child: new Text('评论', style: labelStyle),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.more_horiz, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            PopRoute(
              child: Popup(
                btnContext: context,
                child: _buildExit(),
                onClick: () {
                  print("exit");
                },
              ),
            ),
          );
        });
  }
}
