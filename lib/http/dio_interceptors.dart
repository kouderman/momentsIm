import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/src/response.dart' as Resp;
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/pages/login/login_page.dart';
import 'package:wechat_flutter/tools/sp_util.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../app.dart';
import '../im/login_handle.dart';

// import 'package:get/get_connect/http/src/response/response.dart' hide Response;

/// 自定义拦截器

/// 1、错误统一处理
/// 我们发现虽然Dio框架已经封装了一个DioError类库，但如果需要对返回的错误进行统一弹窗处理或者路由跳转等就只能自定义了;

/// 2、请求前统一处理
/// 在我们发送请求的时候会碰到几种情况，比如需要对非open开头的接口自动加上一些特定的参数，获取需要在请求头增加统一的token;

/// 3、响应前统一处理
/// 在我们请求接口前可以对响应数据进行一些基础的处理，比如对响应的结果进行自定义封装，还可以针对单独的url 做特殊处理等。

class DioInterceptors extends Interceptor {
  // token	 登录成功之后接口会返回token，你需要存储在本地，每次请求带上	用户凭证信息
  // uk	设备的唯一id，请尽量保证针对设备唯一，长度32以内 	用户设备唯一标识
  // channel	请直接填写cretin_open_api 	渠道来源
  // app 	拼接版本号版本标识和系统版本，用;分开，例如 1.0.0;1;10，代表版本号1.0.0，版本标识1，系统为Android 10，其他也类似	app信息
  // device

  @override
  void onResponse(Resp.Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.ok) {
      try {
        LoggerUtil.e(response.data.runtimeType);
        if (response.data is String) {
          var data = json.decode(response.data); //将map数据转换为json字符串
          if (data["code"] == 401) {

             loginOut(buildContext);

          }
        } else {}
      } catch (e) {
        LoggerUtil.e(e);
        return null;
      }
    } else {}
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LoggerUtil.e(err.toString());
    int position = urls.indexOf(baseUrl);
    if (position < urls.length - 1) {
      baseUrl = urls[position + 1];
      SpUtil.saveString("newurl", baseUrl);
    }
  }
}
