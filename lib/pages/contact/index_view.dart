import 'package:dim/commom/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_flutter/config/const.dart';
import 'package:wechat_flutter/config/ui.dart';

import '../../config/logger_util.dart';
import '../home/search_page.dart';
import 'childrecye/childrecye_view.dart';
import 'index_logic.dart';
import 'keep_alive_wrapper.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndexState();
  }
}

class IndexState extends State<IndexPage> with TickerProviderStateMixin {
  static List<int> indexList = [0, 1, 2];
  TabController tabController;

  Widget getTabBar() {
    return TabBar(
        unselectedLabelColor: titleColor,
        labelColor: greenColor,
        isScrollable: true,
        unselectedLabelStyle: TextStyle(fontSize: 16),
        labelStyle: TextStyle(fontSize: 20),
        controller: tabController,
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            text: "推荐",
          ),
          Tab(
            text: "关注",
          ),
          Tab(
            text: "粉丝",
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(vsync: this, length: indexList.length);
    // final controller = Get.find<IndexLogic>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Visibility(
            visible: true,
            child: new InkWell(
              child: new Container(
                width: 60.0,
                child: new Image.asset('assets/images/search_black.webp'),
              ),
              onTap: () {
                routeFadePush(new SearchPage());
              },
            ),
          )
        ],
        flexibleSpace: SafeArea(
          child: Center(child: getTabBar()),
        ),
        backgroundColor: appBarColor,
      ),
      body: TabBarView(
        controller: tabController,
        children: indexList
            .map((e) => KeepAliveWrapper(
                  keepAlive: false,
                  child: ChildrecyePage(
                    type: e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
