import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart' as search;
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:core_location_fluttify/core_location_fluttify.dart' as se;
import 'package:flutter/material.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_flutter/config/logger_util.dart';

import '../../config/const.dart';
import '../../ui/bar/commom_bar.dart';
import '../../ui/button/commom_button.dart';

class Location extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Location> {
  Map<String, Object> _locationResult;

  StreamSubscription<Map<String, Object>> _locationListener;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  @override
  void initState() {
    super.initState();


    AMapFlutterLocation.updatePrivacyShow(true, true);

    AMapFlutterLocation.updatePrivacyAgree(true);
    /// 动态申请定位权限
    ///
    requestPermission();



    AMapFlutterLocation.setApiKey(
        Amapkey, "dfb64c0463cb53927914364b5c09aba0");

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      lat = result["latitude"];
      lng = result["longitude"];
      LoggerUtil.e(lat);
      LoggerUtil.e(lng);
      LoggerUtil.e(result);


      if (lat != 0.0 && lng != 0.0) {
        searchPo();
        lat = result["latitude"];
        lng = result["longitude"];
        _position = CameraPosition(zoom: 15, target: LatLng(lat, lng));
        Marker marker = Marker(position: LatLng(lat, lng));
        _markers[marker.id] = marker;
        setState(() {});
        LoggerUtil.e("刷新map");
      }
    });
  }

  @override
  void dispose() {
    LoggerUtil.e('dispose -----------------------------------------');
    super.dispose();
    _stopLocation();

    ///移除定位监听
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin.destroy();
  }

  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = true;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 5000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void _startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  ///停止定位
  void _stopLocation() {
    _locationPlugin.stopLocation();
  }

  AMapController _mapController;

  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }

  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String mapContentApprovalNumber =
        await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String satelliteImageApprovalNumber =
        await _mapController?.getSatelliteImageApprovalNumber();
  }

  double lat = 0.0000000;
  double lng = 0.0000000;

  CameraPosition _position = null;

  final Map<String, Marker> _markers = <String, Marker>{};

  //Mark样式
  Future<Widget> buildMarkWidget() async {
    //带图片的时候需要先把图片缓存一下，否则不显示
    AssetImage provider = AssetImage('image/group.png');
    await precacheImage(provider, context);
    // Image image = Image(image: provider);//下面也可直接使用image展示
    return Container(
      alignment: Alignment.center,
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('image/group.png')),
      ),
      child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text("金水区99",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      myLocationStyleOptions: MyLocationStyleOptions(true,icon: BitmapDescriptor.defaultMarkerWithHue(0.0)),
      onCameraMove: _onCameraMove,
      onCameraMoveEnd: _onCameraMoveEnd,
      markers: Set<Marker>.of(_markers.values),
      compassEnabled: true,
      initialCameraPosition: _position,
      apiKey: AMapApiKey(
          iosKey: 'Amapkey',
          androidKey: 'Amapkey'),
      // onMapCreated: onMapCreated,
    );
    var body = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: map,
    );

    var rWidget = new ComMomButton(
        text: '确定',
        style: TextStyle(color: Colors.white),
        width: 55.0,
        margin: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
        radius: 4.0,
        onTap: () => Navigator.pop(context, [lat, lng,address]));

    return new Scaffold(
      backgroundColor: appBarColor,
      appBar: new ComMomBar(title: '我的位置', rightDMActions: [rWidget]),
      body: Visibility(
        child: body,
        visible: _position != null,
      ),
    );
  }

  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  void _onCameraMove(CameraPosition cameraPosition) {
    if (null == cameraPosition) {
      return;
    }
    print('onCameraMove===> ${cameraPosition.toMap()}');

    _position = CameraPosition(
        zoom: 15,
        target: LatLng(
            cameraPosition.target.latitude, cameraPosition.target.longitude));
    Marker marker = Marker(icon: BitmapDescriptor.defaultMarkerWithHue(0.0),
        position: LatLng(
            cameraPosition.target.latitude, cameraPosition.target.longitude));
    _markers.clear();
    _markers[marker.id] = marker;
    setState(() {});
  }

  void _onCameraMoveEnd(CameraPosition cameraPosition) {
    if (null == cameraPosition) {
      return;
    }
    lat = cameraPosition.target.latitude;
    lng = cameraPosition.target.longitude;
    LoggerUtil.e(cameraPosition.target);

    searchPo();
  }

  Future<void> searchPo() async {
    LoggerUtil.e('开始搜索 ---------------------'+lat.toString() +"---------"+lng.toString());
    final poiList =
        await search.AmapSearch.instance.searchAround(se.LatLng(lat, lng));


    if(poiList!=null&&poiList.length>0){
      LoggerUtil.e(poiList[0].address);
      address = poiList[0].address;
    }
  }

  String address = '';

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
      _startLocation();
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权

      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
