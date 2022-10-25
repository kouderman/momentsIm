import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/view/image_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ContactCard extends StatelessWidget {
  final String img, title, nickName, id, area, gender, about;
  final bool isBorder;
  final double lineWidth;

  bool isVeried = false;

  ContactCard({
    @required this.img,
    this.title,
    this.id,
    this.nickName,
    this.about,
    this.gender,
    this.area,
    this.isBorder = false,
    this.lineWidth = mainLineWidth,
    this.isVeried,
  }) : assert(id != null);

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 14, color: mainTextColor);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: isBorder
            ? Border(
                bottom: BorderSide(color: lineColor, width: lineWidth),
              )
            : null,
      ),
      width: winWidth(context),
      padding: EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0,top: 20),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new GestureDetector(
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: img != ''
                    ? Image.network(img,
                        width: 50, height: 50, fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/wechat/in/default_nor_avatar.png'),
              ),
              Visibility(
                visible: isVeried,
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
            onTap: () {
              if (isNetWorkImg(img)) {
                routePush(
                  new PhotoView(
                    imageProvider: NetworkImage(img),
                    onTapUp: (c, f, s) => Navigator.of(context).pop(),
                    maxScale: 3.0,
                    minScale: 1.0,
                  ),
                );
              } else {
                showToast(context, '无头像');
              }
            },
          ),
          new Space(width: mainSpace * 2),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    title ?? '未知',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: gender == "F"
                            ? AssetImage('assets/images/F1.png')
                            : AssetImage('assets/images/M1.png'),
                        // fit: BoxFit.fill, // 完全填充
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 12,
                            height: 12,
                            child: gender == "M"
                                ? Image.asset('assets/images/M1_1.png',width: 12,height: 12,)
                                : Image.asset('assets/images/F1_1.png',width: 12,height: 12,)),
                        Text(
                          nickName,
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  // new Space(width: mainSpace / 3),
                  // new Image.asset('assets/images/Contact_Female.webp',
                  //     width: 20.0, fit: BoxFit.fill),
                ],
              ),

              new Text(id, style: labelStyle),
              // new Text("签名:" +about, style: labelStyle),
              new Text("地区：" + area ?? '', style: labelStyle),
            ],
          )
        ],
      ),
    );
  }
}
