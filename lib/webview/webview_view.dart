// import 'dart:async';
// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
//
// import '../config/logger_util.dart';
// import '../ui/bar/commom_bar.dart';
// import 'webview_logic.dart';
//
// import 'dart:io';
//
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebView extends StatefulWidget {
//   String url = "";
//
//   WebView(this.url);
//
//   @override
//   WebViewExampleState createState() => WebViewExampleState();
// }
//
// class WebViewExampleState extends State<WebView> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Enable virtual display.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => WebviewLogic());
//     WebviewLogic webviewLogic = Get.find<WebviewLogic>();
//     InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
//       crossPlatform: InAppWebViewOptions(
//         useShouldOverrideUrlLoading: true,
//         mediaPlaybackRequiresUserGesture: false,
//       ),
//
//       /// android 支持HybridComposition
//       android: AndroidInAppWebViewOptions(
//         useHybridComposition: true,
//       ),
//       ios: IOSInAppWebViewOptions(
//         allowsInlineMediaPlayback: true,
//       ),
//     );
//     WebViewController controller;
//     final double statusBarHeight =
//         MediaQuery.of(context).padding.top; //webview覆盖状态栏 so 减去状态栏高度
//     return Scaffold(
//         appBar: new ComMomBar(title: '网页', ),
//         body: Container(
//       margin: EdgeInsets.only(top: statusBarHeight),
//       child: Stack(
//         children: [
//           InAppWebView(
//             onLoadStop: (controller, uri) {
//               controller.addJavaScriptHandler(
//                   handlerName: 'handlerFoo',
//                   callback: (args) {
//                     // return data to JavaScript side!
//                     return {'bar': 'bar_value', 'baz': 'baz_value'};
//                   });
//               controller.addJavaScriptHandler(
//                   handlerName: 'callJsFunction',
//                   callback: (args) {
//                     print('call js =======================================');
//                     print(args);
//                     // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
//                   });
//             },
//             onWebViewCreated: (controller) {
//               LoggerUtil.e("LoggerUtil--------------", tag: "webview");
//
//               Timer.periodic(const Duration(milliseconds: 1000), (timer) {
//                 webviewLogic.isShow.value = true;
//               });
//             },
//             initialOptions: options,
//             initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
//           ),
//           Obx(() => Offstage(
//                 offstage: webviewLogic.isShow.value,
//                 child: Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   color: Colors.white,
//                   child: const Center(child: Text("加载中...")),
//                 ),
//               ))
//         ],
//       ),
//     ));
//   }
// }
