import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_flutter/config/const.dart';

class InputDetailView extends StatelessWidget implements PreferredSizeWidget {
  const InputDetailView(
      {this.title = '',
      this.showShadow = false,
      this.rightDMActions,
      this.backgroundColor = appBarColor,
      this.mainColor = Colors.black,
      this.titleW,
      this.bottom,
      this.leadingImg = '',
      this.leadingW});

  final String title;
  final bool showShadow;
  final List<Widget> rightDMActions;
  final Color backgroundColor;
  final Color mainColor;
  final Widget titleW;
  final Widget leadingW;
  final PreferredSizeWidget bottom;
  final String leadingImg;

  @override
  Size get preferredSize => new Size(100, 50);


  @override
  Widget build(BuildContext context) {
    return showShadow
        ? new Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: new BorderSide(
                        color: Colors.grey, width: showShadow ? 0.5 : 0.0))),
            child: new AppBar(
              title: titleW == null
                  ? new Text(
                      title,
                      style: new TextStyle(
                          color: mainColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600),
                    )
                  : titleW,
              backgroundColor: mainColor,
              elevation: 0.0,
              brightness: Brightness.light,
              centerTitle: true,
              actions: rightDMActions ?? [new Center()],
              bottom: bottom != null ? bottom : null,
            ),
          )
        : new AppBar(
            title: titleW == null
                ? new Text(
                    title,
                    style: new TextStyle(
                        color: mainColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600),
                  )
                : titleW,
            backgroundColor: backgroundColor,
            elevation: 0.0,
            brightness: Brightness.light,
            centerTitle: false,
            bottom: bottom != null ? bottom : null,
            actions: rightDMActions ?? [new Center()],
          );
  }
}
