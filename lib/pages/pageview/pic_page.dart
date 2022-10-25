import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/im/conversation_handle.dart';
import 'package:wechat_flutter/im/model/chat_list.dart';
import 'package:wechat_flutter/pages/chat/chat_page.dart';
import 'package:wechat_flutter/tools/sp_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/view/indicator_page_view.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/ui/edit/text_span_builder.dart';
import 'package:wechat_flutter/ui/chat/my_conversation_view.dart';
import 'package:wechat_flutter/ui/view/pop_view.dart';

import '../../main.dart';
import '../../routerlistener/PageChangeUtil.dart';
import '../../routerlistener/RouteEvent.dart';
import '../../util/AudioPlayerUtil.dart';

class PicPage extends StatefulWidget {
  List<String> urls;

  PicPage(this.urls);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PicPage> {
  List<String> pageList = [];

  @override
  void initState() {
    super.initState();
    pageList.addAll(widget.urls);
  }

  int _currentPageIndex = 0;


  _buildPageView() {
    return Scaffold(
      appBar: new ComMomBar(title: '图片查看', ),
      body: Center(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index % (pageList.length);
                  });
                },
                itemCount: widget.urls.length,
                itemBuilder: (context, index) {
                  return _buildPageViewItem(pageList[index % (pageList.length)]);
                },
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pageList.length, (i) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPageIndex == i
                                ? Colors.blue
                                : Colors.grey),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildPageViewItem(String txt, {Color color = Colors.red}) {
    return Container(
        // color: color,
        alignment: Alignment.center,
        child: Image.network(txt));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildPageView();
  }
}
