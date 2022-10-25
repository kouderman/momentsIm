import 'package:flutter/cupertino.dart';

class RouteEvent {
 PageRoute<dynamic> route;
 String pageNmae;
 ActionType type;
 bool isCurrent;
 RouteEvent(this.pageNmae, this.type, this.route,this.isCurrent);
}

enum ActionType { DID_PUSH, DID_REPLACE, DID_POP, DID_REMOVE }

