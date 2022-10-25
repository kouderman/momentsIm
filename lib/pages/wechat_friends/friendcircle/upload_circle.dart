import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/httpbean/respuploadmedia.dart';
import 'package:wechat_flutter/im/group/fun_dim_info.dart';
import 'package:wechat_flutter/pages/wechat_friends/friendcircle/XfileWrapper.dart';
import 'package:wechat_flutter/pages/wechat_friends/friendcircle/publish_type.dart';
import 'package:wechat_flutter/pages/wechat_friends/friendcircle/video_play.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../../config/appdata.dart';
import '../../../config/const.dart';
import '../../../http/Method.dart';
import '../../../tools/sp_util.dart';
import '../../../ui/bar/commom_bar.dart';
import '../../../ui/button/commom_button.dart';
import 'package:http_parser/http_parser.dart';
import '../../../ui/view/edit_view.dart';
import '../ui/load_view.dart';

class ImageUploadRoute extends StatefulWidget {
  ImageUploadRoute({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUploadRoute> {
  TextEditingController _controller;

  List<XFileWrapper> _imageFileList = List.empty(growable: true); //存放选择的图片
  final ImagePicker _picker = ImagePicker();
  int maxFileCount = 9;
  dynamic _pickImageError;
  int _bigImageIndex = 0;
  bool _bigImageVisibility = false;

  int getImageCount() {
    if (_imageFileList.length < maxFileCount) {
      return _imageFileList.length + 1;
    } else {
      return _imageFileList.length;
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Widget _previewImages() {
    return GridView.builder(
      physics: new NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        if (_imageFileList.length < maxFileCount) {
          //没选满
          if (index < _imageFileList.length) {
            //需要展示的图片
            return Stack(
              //层叠布局 图片上面要有一个删除的框
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: GestureDetector(
                      child: Image.file(File(_imageFileList[index].xFile.path),
                          fit: BoxFit.cover),
                      onTap: () => () {},
                    )),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  width: 20,
                  height: 20,
                  child: GestureDetector(
                    child: SizedBox(
                      child: Image.asset('assets/images/delete.png'),
                    ),
                    onTap: () => _removeImage(index),
                  ),
                ),
              ],
            );
            //return Image.file(File(_imageFileList[index].path),fit:BoxFit.cover ,) ;
          } else {
            //显示添加符号
            return GestureDetector(
              //手势包含添加按钮 实现点击进行选择图片
              child: Image.asset(
                'assets/images/group/+.png',
                width: 60,
                height: 60,
              ),
              onTap: () => _onImageButtonPressed(
                //执行打开相册
                ImageSource.gallery,
                context: context,
                // imageQuality: 40, //图片压缩
              ),
            );
          }
        } else {
          return Stack(
            //满了
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: GestureDetector(
                  child: Image.file(File(_imageFileList[index].xFile.path),
                      fit: BoxFit.cover),
                  onTap: () => showBigImage(index),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                width: 20,
                height: 20,
                child: GestureDetector(
                  child: SizedBox(
                    child: Image.asset('assets/images/delete.png'),
                  ),
                  onTap: () => _removeImage(index),
                ),
              ),
            ],
          );
        }
      },
      itemCount: getImageCount(),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext context,
      double maxHeight,
      double maxWidth,
      int imageQuality}) async {
    try {
      _publishType = PublishType.Image;
      final pickedFileList = await _picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      XFile img = pickedFileList[0];

      XFileWrapper xFileWrapper = XFileWrapper(xFile: img);

      if (img != null) {
        var path = img.path;
        LoggerUtil.e(path);
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);

        if(showtoast){
          showToast(context, "lat ="+SpUtil.getDouble("lat").toString() );
        }
        Map<String, dynamic> map = Map();
        map["license"] = AppData.licence;
        map["type"] = "image";
        map["lat"] = SpUtil.getDouble("lat");
        map["lng"] = SpUtil.getDouble("lng");
        map["session_id"] = SpUtil.getString("authToken");
        map["file"] = await MultipartFile.fromFile(path,
            filename: name, contentType: new MediaType("image", "jpeg"));

        FormData formData2 = FormData.fromMap(map);

        // EasyLoading.show(status: '加载中...');
        DioUtil().post('$baseUrl/upload_post_media',
            data: formData2, errorCallback: (statusCode) {
          EasyLoading.dismiss();
          print('Http error code : $statusCode');
          // EasyLoading.showToast(statusCode);
        }).then((data) {
          Respuploadmedia respuploadmedia = Respuploadmedia.fromJson(data);

          String id = respuploadmedia.data.mediaId.toString();
          String url = respuploadmedia.data.url.toString();
          xFileWrapper.id = id;

          setState(() {
            if (_imageFileList.length < maxFileCount) {
              if ((_imageFileList.length + (pickedFileList?.length ?? 0)) <=
                  maxFileCount) {
                pickedFileList.forEach((element) {
                  _imageFileList
                      .add(XFileWrapper(xFile: element, id: id, url: url));
                });
              } else {
                int avaliableCount = maxFileCount - _imageFileList.length;
                for (int i = 0; i < avaliableCount; i++) {
                  _imageFileList.add(
                      XFileWrapper(xFile: pickedFileList[i], id: id, url: url));
                }
              }
            }
          });

          // EasyLoading.dismiss();
          print('Http response: $data');
        });
      }
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _removeImage(int index) {
    String token = SpUtil.getString("authToken");

    EasyLoading.show(status: '加载中...');
    DioUtil()
        .post('$baseUrl/delete_post_media', data: {
      "license": AppData.licence,
      "type": "image",
      "media_id": _imageFileList[index].id,
      "session_id": token,
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          setState(() {
            _imageFileList.removeAt(index);
          });
        } else {
          EasyLoading.showToast(data["message"]);
        }
      }
    });
  }

  //通过双击小图的时候获取当前需要放大预览的图的下标
  void showBigImage(int index) {
    setState(() {
      _bigImageIndex = index;
      _bigImageVisibility = true;
    });
  }

  //通过大图的双击事件 隐藏大图
  void hiddenBigImage() {
    setState(() {
      _bigImageVisibility = false;
    });
  }

  //展示大图
  Widget displayBigImage() {
    if (_imageFileList.length > _bigImageIndex) {
      return Image.file(File(_imageFileList[_bigImageIndex].xFile.path),
          fit: BoxFit.fill);
    } else {
      return null;
    }
  }

  //初始化的时候打开定位相关
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  TextEditingController old = new TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    old.dispose();
    super.dispose();
  }

  PublishType _publishType = PublishType.Image;

  //页面的控件布局
  @override
  Widget build(BuildContext context) {
    var rWidget = new ComMomButton(
      text: '发布',
      style: TextStyle(color: Colors.white),
      width: 60.0,
      margin: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
      radius: 4.0,
      onTap: () => publishShare(),
    );
    return Scaffold(
        backgroundColor: appBarColor,
        appBar: new ComMomBar(title: '发布说说', rightDMActions: [rWidget]),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  new TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '说点什么吧...',
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.5),
                            fontSize: 16.0)),
                    controller: old,
                    onChanged: (str) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: _publishType == PublishType.Image,
                    child: SizedBox(
                      height: 400,
                      child: _handlePreview(),
                    ),
                  ),
                  Visibility(
                    visible: _publishType == PublishType.Video,
                    child: SizedBox(
                      height: 100,
                      child: buildVideoView(),
                    ),
                  ),
                  // Divider(
                  //   height: 1,
                  //   color: Colors.blue,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        //手势包含添加按钮 实现点击进行选择图片
                        child: Image.asset(
                          'assets/images/upload_image.png',
                          width: 30,
                          height: 30,
                        ),
                        onTap: () => _onImageButtonPressed(
                          //执行打开相册
                          ImageSource.gallery,
                          context: context,
                          // imageQuality: 40, //图片压缩
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        //手势包含添加按钮 实现点击进行选择图片
                        child: Image.asset(
                          'assets/images/upload_video.png',
                          width: 30,
                          height: 30,
                        ),
                        onTap: () => publishVideo(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ComMomButton(
                        text: "上传",
                        onTap: () => publishVideo(),
                        style: TextStyle(color: Colors.white),
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        color: Color.fromRGBO(8, 191, 98, 1.0),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  var thumbPath = '';

  buildVideoView() {
    return Container(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            print('click');
            if (videoPath != '') {
              routePush(VideoApp(src: videoPath));
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ImageView(
                width: 100,
                height: 100,
                img: thumbPath,
              ),
              IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    print('click');
                    if (videoPath != '') {
                      routePush(VideoApp(src: videoPath));
                    }
                  })
            ],
          ),
        ),
        width: 100);
  }

  String videoPath = "";

  void publishVideo() async {
    _publishType = PublishType.Video;
    _imageFileList.clear();
    final XFile video = await _picker.pickVideo(source: ImageSource.camera);
    video
        .length()
        .then((value) => LoggerUtil.e(video.path + "," + value.toString()));
    LoggerUtil.e(video.path + ",");

    videoPath = video.path;

    if (videoPath != '') {
      //将视频mp4格式的地址转成png格式，判断文件中是否有存在过（插件生成过）
      String thumPhotoPath = videoPath.toString(); //video是视频地址
      thumbPath = thumPhotoPath.substring(0, thumPhotoPath.length - 3) +
          "png"; //将地址后面的mp4去掉，再添加png，判断这个地址文件是否存在
      File photoPath = File(thumbPath);

      //返回真假
      var pathBool = await photoPath.exists();
      //如果已经存在就直接将mp4格式地址转成png格式地址
      if (pathBool == true) {
        String path = videoPath.toString();
        thumbPath = path.substring(0, path.length - 3) + "png"; //如果存在就直接用
      } else {
        //如果没有存在就重新获取视频缩略图
        String thumbnailPath = await VideoThumbnail.thumbnailFile(
            video: videoPath,
            imageFormat: ImageFormat.PNG,
            maxWidth: 300,
            quality: 25);
        thumbPath = thumbnailPath;
      }
      LoggerUtil.e(thumbPath);
    }

    if (video != null) {
      setState(() {});
      var path = video.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);

      if(showtoast){
        showToast(context, "lat ="+SpUtil.getDouble("lat").toString() );
      }
      Map<String, dynamic> map = Map();
      map["license"] = AppData.licence;
      map["type"] = "video";
      map["lat"] = SpUtil.getDouble("lat");
      map["lng"] = SpUtil.getDouble("lng");

      map["session_id"] = SpUtil.getString("authToken");
      map["file"] = await MultipartFile.fromFile(path,
          filename: name, contentType: new MediaType("video", "mp4"));

      FormData formData2 = FormData.fromMap(map);

      // EasyLoading.show(status: '加载中...');
      DioUtil().post('$baseUrl/upload_post_media',
          data: formData2, errorCallback: (statusCode) {
        EasyLoading.dismiss();
        print('Http error code : $statusCode');
        // EasyLoading.showToast(statusCode);
      }).then((data) {
        // EasyLoading.dismiss();
        print('Http response: $data');
      });
    }

    setState(() {});
  }

  String lat = "";
  String lng = "";

  void getLocation() async {
    if (await Permission.location.request().isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.high);
      LoggerUtil.e(position.latitude);
      LoggerUtil.e(position.longitude);
      lat = position.latitude.toString();
      lng = position.longitude.toString();
    }
  }

  publishShare() {
    List<String> list = [];
    _imageFileList.forEach((element) {
      list.add(element.url);
    });
    EasyLoading.show(status: '加载中...');
    if(showtoast){
      showToast(context, "lat ="+SpUtil.getDouble("lat").toString() );
    }
    DioUtil().post('$baseUrl/publish_post', data: {
      "license": AppData.licence,
      "post_text": old.text ?? '',
      "lat": SpUtil.getDouble("lat"),
      "lng": SpUtil.getDouble("lng"),
      "og_data": list,
      "session_id": SpUtil.getString("authToken"),
    }, errorCallback: (statusCode) {
      EasyLoading.dismiss();
      print('Http error code : $statusCode');
      EasyLoading.showToast(statusCode);
    }).then((data) {
      EasyLoading.dismiss();
      print('Http response: $data');

      if (data != null) {
        if (data["code"] == 200 || data["code"] == 0) {
          Navigator.pop(context, true);
        } else {
          EasyLoading.showToast(data["message"]);
        }
      }
    });
  }
}
