import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/pages/contacts/group_launch_page.dart';
import 'package:wechat_flutter/pages/home/search_page.dart';
import 'package:wechat_flutter/pages/settings/language_page.dart';
import 'package:wechat_flutter/ui/view/indicator_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/pages/more/add_friend_page.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/w_pop/w_popup_menu.dart';

import '../wechat_friends/friendcircle/upload_circle.dart';
import '../wechat_friends/search_post/search_post_view.dart';

typedef CheckLogin(index);

class RootTabBar extends StatefulWidget {
  RootTabBar({this.pages, this.checkLogin, this.currentIndex = 0});

  final List pages;
  final CheckLogin checkLogin;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => new RootTabBarState();
}

class RootTabBarState extends State<RootTabBar> {
  var pages = new List<BottomNavigationBarItem>();
  int currentIndex;
  var contents = new List<Offstage>();
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    pageController = PageController(initialPage: currentIndex);
    for (int i = 0; i < widget.pages.length; i++) {
      TabBarModel model = widget.pages[i];
      pages.add(
        new BottomNavigationBarItem(
          icon: model.icon,
          activeIcon: model.selectIcon,
          label: model.title,
        ),
      );
    }
  }

  actionsHandle(v) {
    if (v == '添加朋友') {
      routePush(new AddFriendPage());
    } else if (v == '发起群聊') {
      routePush(new GroupLaunchPage());
    } else if (v == '帮助与反馈') {
      routePush(new WebViewPage(helpUrl, '帮助与反馈'));
    } else {
      routePush(new LanguagePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List actions = [
      {"title": '发起群聊', 'icon': 'assets/images/contacts_add_newmessage.png'},
      {"title": '添加朋友', 'icon': 'assets/images/ic_add_friend.webp'},
      {"title": '扫一扫', 'icon': ''},
      {"title": '收付款', 'icon': ''},
      {"title": '帮助与反馈', 'icon': ''},
    ];

    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: pages,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      fixedColor: greenColor,
      unselectedItemColor: titleColor,
      onTap: (int index) {
        setState(() => currentIndex = index);
        pageController.jumpToPage(currentIndex);
        // widget.count = Random().nextInt(10).toString();
        setState(() {});
      },
      unselectedFontSize: 12.0,
      selectedFontSize: 12.0,
      elevation: 0,
      // title: new Text(model.title, style: new TextStyle(fontSize: 12.0)),
    );

    var appBar = new ComMomBar(
      title: widget.pages[currentIndex].title,
      // titleW: Visibility(
      //   visible: currentIndex == 0,
      //   child: Text('消息',style: TextStyle(fontSize: 20),),
      // ),
      showShadow: false,
      rightDMActions: <Widget>[
        Visibility(
          visible: currentIndex != 0,
          child: new InkWell(
            child: new Container(
              width: 60.0,
              child: new Image.asset('assets/images/search_black.webp'),
            ),
            onTap: () {
              if (currentIndex == 1) {
                routeFadePush(new SearchPage());
              } else {
                routeFadePush(new Search_postPage());
              }
            },
          ),
        ),
        Visibility(
          visible: currentIndex == 2,
          child: IconButton(
            icon: Image.asset('assets/images/camera.png',width: 30,height: 30,),
            onPressed: () => routePush(ImageUploadRoute()),
          ),
        )
      ],
    );

    return new Scaffold(
      bottomNavigationBar: new Theme(
        data: new ThemeData(
          canvasColor: Colors.grey[50],
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: new Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: lineColor, width: 0.2))),
          child: bottomNavigationBar,
        ),
      ),
      appBar:
      currentIndex==0 ? appBar : null,
      body: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new PageView.builder(
          itemBuilder: (BuildContext context, int index) =>
              widget.pages[index].page,
          controller: pageController,
          itemCount: pages.length,
          physics: NeverScrollableScrollPhysics(),
          // physics: Platform.isAndroid
          //     ? new ClampingScrollPhysics()
          //     : new NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() => currentIndex = index);
          },
        ),
      ),
    );
  }
}

class TabBarModel {
  const TabBarModel({this.title, this.page, this.icon, this.selectIcon});

  final String title;
  final Widget icon;
  final Widget selectIcon;
  final Widget page;
}
