import 'package:flutter/material.dart';
import 'package:wechat_flutter/config/logger_util.dart';

import 'PageChangeUtil.dart';
import 'RouteEvent.dart';

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route, ActionType type) {
    var screenName = route.settings.name;
    var isCurrent = route.isCurrent;

    LoggerUtil.e('screenName is $screenName , isCurrent is $isCurrent');

    PageChangeUtil()
        .pushRouteDetail(RouteEvent(screenName ?? '', type, route, isCurrent));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      LoggerUtil.e('didPush');
      _sendScreenView(route, ActionType.DID_PUSH);
    }
    //
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute, ActionType.DID_REPLACE);
    }

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      LoggerUtil.e('didPop');
      _sendScreenView(previousRoute, ActionType.DID_POP);
    }
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);
    if(previousRoute is PageRoute && route is PageRoute){
      _sendScreenView(previousRoute, ActionType.DID_REMOVE);
    }
  }
}

