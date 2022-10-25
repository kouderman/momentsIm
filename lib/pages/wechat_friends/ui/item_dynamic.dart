import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wechat_flutter/callback/callback.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/httpbean/post.dart';
import 'package:wechat_flutter/pages/wechat_friends/from.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart' as prefix1;
import 'package:wechat_flutter/ui/w_pop/friend_pop.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:flutter/material.dart' as prefix0;

import '../../../config/appdata.dart';
import '../../../http/Method.dart';
import '../../../httpbean/resplike.dart';
import '../../../tools/sp_util.dart';
import '../../pageview/pic_page.dart';
import '../friendcircle/video_play.dart';
import '../friendcircle_item_detail/friendcircle_item_detail_view.dart';
import 'load_view.dart';

class ItemDynamic extends StatelessWidget {
  final Post dynamic;
  final DeleteCallBack deleteCallBack;
  final LikeCallBack likeCallBack;

  ItemDynamic(this.dynamic, {Key key, this.deleteCallBack, this.likeCallBack})
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
      onTap: () {
        print('click');
        routePush(Friendcircle_item_detailPage(dynamic, likeCallBack));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ImageLoadView(
                dynamic.owner.avatar, //头像
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
                            '${this.dynamic.owner.name}',
                            style:
                                TextStyle(color: postNameColor, fontSize: 18),
                          ),

                          /// 发布的文字描述
                          Offstage(
                              offstage: desc.isEmpty,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text('$desc',
                                      style: TextStyle(color: postContentColor),

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
                                              showBigDialog(
                                                  c, this.dynamic.media[0].src);
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

                          /// 视频区域
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
                                                src:
                                                    this.dynamic.media[0].src));
                                          })
                                    ],
                                  ),
                                  width: videoWidth)),

                          /// 定位地址
                          Row(
                            children: [
                              Visibility(
                                  visible: true,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text('${this.dynamic.area}',
                                          style: TextStyle(
                                              color: postareaColor,
                                              fontSize: 12)))),
                              Expanded(child: Text('')),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
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
                              ),
                            ],
                          ),
                          // Visibility(child: TextField(),),

                          /// 发布时间
                          Row(children: <Widget>[
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('${this.dynamic.time}',
                                      style: TextStyle(
                                          color: postareaColor,
                                          fontSize: 12)),
                                  Visibility(
                                      visible: this.dynamic.canDelete,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              deleteCallBack(
                                                  this.dynamic.id.toString());
                                            },
                                            child: Text('删除',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                    postNameColor)),
                                          )))
                                ]),
                            // TestPush(this.dynamic, this.likeCallBack),
                          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),

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
  TestPush(this.post, this.likeCallBack);

  Post post;
  LikeCallBack likeCallBack;

  @override
  _TestPushState createState() => _TestPushState();
}

class _TestPushState extends State<TestPush> {
  bool hasLike = false;

  void likePost(String postId) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/like_post', data: {
      "post_id": postId,
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
          Resplike resplike = Resplike.fromJson(data);
          if (resplike.data.like) {
            // likes.add(postId);
            setState(() {});
            hasLike = resplike.data.like;
            showToast(context, '点赞成功');
          } else {
            // likes.remove(postId);
            setState(() {});
            showToast(context, '取消点赞成功');
          }
        } else {}
      }
    });
  }

  Widget _buildExit(BuildContext context) {
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
                likePost(widget.post.id.toString());
                Navigator.of(context).pop();
                // widget.likeCallBack(widget.post.id.toString());
              },
              child: new Text(hasLike ? '取消赞' : '赞', style: labelStyle),
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
    hasLike = widget.post.hasLiked;
    return IconButton(
        icon: Icon(Icons.more_horiz, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            PopRoute(
              child: Popup(
                btnContext: context,
                child: _buildExit(context),
                onClick: () {
                  print("exit");
                },
              ),
            ),
          );
        });
  }
}
