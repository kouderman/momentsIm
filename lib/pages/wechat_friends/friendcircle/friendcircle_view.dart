import 'package:dim/commom/win_media.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/httpbean/respupdatebg.dart';
import 'package:wechat_flutter/pages/mine/areaevent.dart';
import 'package:wechat_flutter/pages/wechat_friends/friendcircle/upload_circle.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import 'package:http_parser/http_parser.dart';
import '../../../http/Method.dart';
import '../../../httpbean/resplike.dart';
import '../../../main.dart';
import '../../../tools/sp_util.dart';
import '../../../ui/bar/commom_bar.dart';
import 'package:dio/src/multipart_file.dart';
import '../chat_style.dart';
import '../page/publish_dynamic.dart';
import '../ui/item_dynamic.dart';
import '../ui/load_view.dart';
import 'friendcircle_controller.dart';
import 'package:dio/dio.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

class FriendcirclePage extends StatefulWidget {
  FriendcirclePage(this.userid, this.cover, this.avatar, this.name);

  String userid;
  String cover;
  String avatar;
  String name;

  @override
  createState() => _WeChatFriendsCircleState();
}

class _WeChatFriendsCircleState extends State<FriendcirclePage> with RouteAware {
  double navAlpha = 0;
  double headerHeight;
  ScrollController scrollController = ScrollController();

  Color c = Colors.grey;
  String title = '';

  List<String> likes = [];

  int maxImages = 9;

  FriendcircleController controller;
  EventBus eventBus = EventBus();

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)); //订阅
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    LoggerUtil.e("------> didPush");
    super.didPush();
    if(mounted){
      controller.getdata(widget.userid);
    }
  }

  @override
  void didPop() {
    LoggerUtil.e("------> didPop");
    super.didPop();
  }

  @override
  void didPopNext() {
    LoggerUtil.e("------> didPopNext");
    super.didPopNext();
    if(mounted){
      controller.getdata(widget.userid);
    }
  }

  @override
  void didPushNext() {
    LoggerUtil.e("------> didPushNext");

    super.didPushNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); //取消订阅
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Get.lazyPut(() => FriendcircleController());
    controller = Get.find<FriendcircleController>();




    controller.path = SpUtil.getString("cover");

    headerHeight = 260;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() => navAlpha = 0);
        }
      } else if (offset < headerHeight) {
        if (headerHeight - offset <= navigationBarHeight(context)) {
          setState(() {
            c = Colors.black;
            title = '朋友圈';
          });
        } else {
          c = Colors.white;
          title = '';
        }
        setState(() => navAlpha = 1 - (headerHeight - offset) / headerHeight);
      } else if (navAlpha != 1) {
        setState(() => navAlpha = 1);
      }
    });
  }

  _openGallery() async {
    XFile img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      var path = img.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);

      Map<String, dynamic> map = Map();
      map["license"] = AppData.licence;
      map["session_id"] = SpUtil.getString("authToken");
      map["action"] = "cover";
      map["file"] = await MultipartFile.fromFile(path,
          filename: name, contentType: new MediaType("image", "jpeg"));

      FormData formData2 = FormData.fromMap(map);

      DioUtil().post('$baseUrl/upload_avatar',
          data: formData2, errorCallback: (statusCode) {
        EasyLoading.dismiss();
        print('Http error code : $statusCode');
        // EasyLoading.showToast(statusCode);
      }).then((data) {
        if (data != null) {
          if (data["code"] == 200 || data["code"] == 0) {
            showToast(context, '上传成功');
            Respupdatebg respavatar = Respupdatebg.fromJson(data);

            final controller = Get.find<FriendcircleController>();
            controller.path = respavatar.data.url;
            SpUtil.saveString("cover", respavatar.data.url);
            widget.cover = respavatar.data.url;
            setState(() {});
          } else {}
        }

        // EasyLoading.dismiss();
        print('Http response: $data');
      });
    }
  }

  String coverurl() {
    if (!widget.cover.startsWith("http")) {
      return backgroundImage;
    }
    if (widget.cover == '') {
      return backgroundImage;
    }
    return widget.cover;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                        color: Colors.transparent,
                        height: headerHeight,
                        width: winWidth(context),
                        child: GestureDetector(
                          onTap: changeBackGround,
                          child: ImageLoadView(coverurl(),
                              fit: BoxFit.cover,
                              height: headerHeight,
                              width: winWidth(context)),
                        ),
                        margin: EdgeInsets.only(bottom: 30.0)),
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: Text(widget.name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                              ),
                            ),
                            ImageLoadView(
                              widget.avatar,
                              height: 70,
                              width: 70,
                              borderRadius: BorderRadius.circular(5.0),
                            )
                          ]),
                      margin: EdgeInsets.only(right: 10),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Obx(
                  () => ListView.builder(
                      itemCount: controller.list.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => ItemDynamic(
                            controller.list[index],
                            likeCallBack: (postId) {
                              likePost(postId);
                            },
                            deleteCallBack: (postId) {
                              deletePost(postId);
                            },
                          )),
                ),
              ]),
            ),
            Container(
              height: navigationBarHeight(context) + 10,
              child: new ComMomBar(
                title: title,
                rightDMActions: <Widget>[
                  Visibility(
                    visible: widget.userid == SpUtil.getString("userid"),
                    child: IconButton(
                      icon: Image.asset('assets/images/camera.png'),
                      onPressed: () => _showDialog(context),
                    ),
                  )
                ],
                backgroundColor:
                    Color.fromARGB((navAlpha * 255).toInt(), 237, 237, 237),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getData() async {}

  void _showDialog(BuildContext context) {
    // Navigator.of(context)
    //     .push(
    //       new MaterialPageRoute(builder: (_) => ImageUploadRoute()),
    //     )
    //     .then((val) => controller.getdata(widget.userid));

    routePush(ImageUploadRoute());

    // showDialog(
    //     context: context,
    //     builder: (context) => CupertinoAlertDialog(actions: <Widget>[
    //           CupertinoDialogAction(
    //             child: Text('拍摄', style: TextStyles.textBlue16),
    //             onPressed: () {
    //               /// TODO
    //               Navigator.pop(context);
    //             },
    //           ),
    //           CupertinoDialogAction(
    //             child: Text('从相册选择', style: TextStyles.textBlue16),
    //             onPressed: () {
    //               routePush(ImageUploadRoute());
    //             },
    //           ),
    //           CupertinoDialogAction(
    //             child: Text('取消', style: TextStyles.textRed16),
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           )
    //         ]));
  }

  void changeBackGround() {
    print('click');
    if(widget.userid == SpUtil.getString("userid")){
      _openGallery();
    }

  }

  void deletePost(String postId) {
    EasyLoading.show(status: '加载中...');
    String authToken = SpUtil.getString("authToken");
    DioUtil().post('$baseUrl/delete_post', data: {
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
          controller.delete(postId);
        } else {}
      }
    });
  }

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
            likes.add(postId);
            showToast(context, '点赞成功');
          } else {
            likes.remove(postId);
            showToast(context, '取消点赞成功');
          }
        } else {}
      }
    });
  }
}
