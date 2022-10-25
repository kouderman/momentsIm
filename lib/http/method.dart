import 'dart:convert';
import 'dart:io';
 
import 'package:dio/dio.dart';
import 'package:wechat_flutter/config/const.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'dart:convert';

import 'dio_interceptors.dart';
 
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}
 
class DioUtil {
  static final DioUtil _instance = DioUtil._init();
  static Dio _dio;
  static BaseOptions _options = getDefOptions();
 
  factory DioUtil() {
    return _instance;
  }
 
  DioUtil._init() {
    _dio = new Dio();
    setOptions(getDefOptions());
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));

    _dio.interceptors.add(DioInterceptors());

  }
 
  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = 15 * 1000;
    options.receiveTimeout = 15 * 1000;
    options.contentType = 'application/x-www-form-urlencoded';
    options.responseType = ResponseType.plain;
 
    Map<String, dynamic> headers = Map<String, dynamic>();
    options.headers["connection"]="keep-alive";
    options.headers["accept-encoding"]="gzip, deflate, br";
    options.headers["accept"]="*/*";
 
    String platform;
    if(Platform.isAndroid) {
      platform = "Android";
    } else if(Platform.isIOS) {
      platform = "IOS";
    }
    // headers['OS'] = platform;
    options.headers = headers;
 
    return options;
  }
 
  setOptions(BaseOptions options) {
    _options = options;
    _dio.options = _options;
  }
 
  Future<Map<String, dynamic>> get(String path, {pathParams, data, Function errorCallback}) {
    return request(path, method: Method.get, pathParams: pathParams, data: data, errorCallback: errorCallback);
  }
 
  Future<Map<String, dynamic>> post(String path, {pathParams, data, Function errorCallback}) {
    return request(path, method: Method.post, pathParams: pathParams, data: data, errorCallback: errorCallback);
  }
 
  Future<Map<String, dynamic>> request(String path,{String method, Map pathParams, data, Function errorCallback}) async {

    ///restful请求处理
    if(pathParams != null) {
      pathParams.forEach((key, value) {
        if(path.indexOf(key) != -1) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    }
 
    Response response = await _dio.request(path, data: data, options: Options(method: method));


    if(response.statusCode == HttpStatus.ok ) {

      try {
        if(response.data is Map) {
          var data = json.encode(response.data);//将map数据转换为json字符串
          LoggerUtil.e(data.toString());
          return response.data;
        } else {
          print('=========resp1 json>');
          return json.decode(response.data.toString());
        }
      } catch(e) {
        return null;
      }
    } else {
      _handleHttpError(response.statusCode);
      if(errorCallback != null) {
        errorCallback(response.statusCode);
      }
      return null;
    }
  }
 
  ///处理Http错误码
  void _handleHttpError(int errorCode) {
 
  }
 
}