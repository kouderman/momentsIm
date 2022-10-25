import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/ui/message_view/content_msg.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

class MyConversationView extends StatefulWidget {
  final String imageUrl;
  final String title;
  final Map content;
  final Widget time;
  final bool isBorder;
  String unread = "0";

  MyConversationView(
      {this.imageUrl,
      this.title,
      this.content,
      this.time,
      this.isBorder = true,
      this.unread});

  @override
  _MyConversationViewState createState() => _MyConversationViewState();
}

class _MyConversationViewState extends State<MyConversationView> {
  @override
  Widget build(BuildContext context) {
    var row = new Row(
      children: <Widget>[
        // new Space(width: mainSpace),
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                widget.title ?? default_avatar,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600,color: titleColor),
              ),
              new SizedBox(height: 2.0),
              Row(
                children: [
                  Visibility(
                      child: Visibility(
                          visible: widget.unread != "0",
                          child: Text('[${widget.unread}条]',
                              style: TextStyle(color: subtitleColor,
                               fontSize: 12.0)))),
                  Visibility(
                    child: SizedBox(width: 10),
                    visible: widget.unread != "0",
                  ),
                  new ContentMsg(widget?.content)
                ],
              ),
            ],
          ),
        ),
        // new Space(width: mainSpace),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: new Column(
            children: [
              widget.time,
              Visibility(
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  visible: widget.unread != "0",
                  child: Text('未读${widget.unread}',
                      style: TextStyle(color: Colors.red, fontSize: 12.0))),
              // new Icon(Icons.flag, color: Colors.transparent),
            ],
          ),
        )
      ],
    );

    return new Container(
      padding: EdgeInsets.only(left: 10.0),
      color: Colors.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new ImageView(
              img: widget.imageUrl ?? default_avatar,
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover),
          Space(),
          new Container(
            padding: EdgeInsets.only(right: 0.0, top: 12.0, bottom: 12.0,),
            width: winWidth(context)-70 ,
            decoration: BoxDecoration(
              border: true
                  ? Border(
                      bottom: BorderSide(color: lineColor, width: 0.2),

                    )
                  : null,
            ),
            child: row,
          )
        ],
      ),
    );
  }
}
