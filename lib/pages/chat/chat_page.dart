import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/im/model/chat_data.dart';
import 'package:wechat_flutter/main.dart';
import 'package:wechat_flutter/pages/chat/chat_more_page.dart';
import 'package:wechat_flutter/pages/group/group_details_page.dart';
import 'package:wechat_flutter/tools/sp_util.dart';
import 'package:wechat_flutter/ui/chat/chat_details_body.dart';
import 'package:wechat_flutter/ui/chat/chat_details_row.dart';
import 'package:wechat_flutter/ui/item/chat_more_icon.dart';
import 'package:wechat_flutter/ui/view/indicator_page_view.dart';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:wechat_flutter/im/send_handle.dart';
import 'package:wechat_flutter/tools/wechat_flutter.dart';
import 'package:wechat_flutter/ui/edit/text_span_builder.dart';
import 'package:wechat_flutter/ui/edit/emoji_text.dart';
import '../../im/conversation_handle.dart';
import '../../util/AudioPlayerUtil.dart';
import 'chat_info_page.dart';

enum ButtonType { voice, more }

class ChatPage extends StatefulWidget {
  final String title;
  final int type;
  final String id;

  ChatPage({this.id, this.title, this.type = 1});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatData> chatData = [];
  StreamSubscription<dynamic> _msgStreamSubs;
  final ImagePicker _picker = ImagePicker();
  bool _isVoice = false;
  bool _isMore = false;
  double keyboardHeight = 270.0;
  bool _emojiState = false;
  String newGroupName;

  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = new FocusNode();
  ScrollController _sC = ScrollController();
  PageController pageC = new PageController();

  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      _startLocation();
      print("定位权限申请通过");
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

  Map<String, Object> _locationResult;

  StreamSubscription<Map<String, Object>> _locationListener;

  void _setLocationOption() {
    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = true;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

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

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();
  ///开始定位
  void _startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin.startLocation();
  }
  @override
  void initState() {
    super.initState();
    isListener = false;
    // LoggerUtil.e("进入聊天${widget.id} ,${widget.title}");
    // requestPermission();
    AMapFlutterLocation.updatePrivacyShow(true, true);

    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限


    AMapFlutterLocation.setApiKey(Amapkey, "dfb64c0463cb53927914364b5c09aba0");

    _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
      // LoggerUtil.e(result);

      SpUtil.saveDouble("latitude", result["latitude"]);
      SpUtil.saveDouble("longitude", result["longitude"]);
    });

    getChatMsgData();

    _sC.addListener(() => FocusScope.of(context).requestFocus(new FocusNode()));
    initPlatformState();
    Notice.addListener(WeChatActions.msg(), (v) => getChatMsgData());
    if (widget.type == 2) {
      Notice.addListener(WeChatActions.groupName(), (v) {
        setState(() => newGroupName = v);
      });
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) _emojiState = false;
    });
    setReadMessageModel(widget.type, widget.id);
  }

  Future getChatMsgData() async {
    final str =
        await ChatDataRep().repData(widget?.id ?? widget.title, widget.type);
    List<ChatData> listChat = str;
    chatData.clear();
    chatData..addAll(listChat.reversed);
    if (mounted) setState(() {});
  }

  void insertText(String text) {
    var value = _textController.value;
    var start = value.selection.baseOffset;
    var end = value.selection.extentOffset;
    if (value.selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }

      _textController.value = value.copyWith(
          text: newText,
          selection: value.selection.copyWith(
              baseOffset: end + text.length, extentOffset: end + text.length));
    } else {
      _textController.value = TextEditingValue(
          text: text,
          selection:
              TextSelection.fromPosition(TextPosition(offset: text.length)));
    }
  }

  void canCelListener() {
    if (_msgStreamSubs != null) _msgStreamSubs.cancel();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    if (_msgStreamSubs == null) {
      _msgStreamSubs =
          im.onMessage.listen((dynamic onData){
            getChatMsgData();
            // LoggerUtil.e("====="+onData);
            if(onData  != '[]'){
              // AudioPlayerUtil.instance.playLocalSuccess();
            }

          });
    }
  }

  _handleSubmittedData(String text) async {
    _textController.clear();
    chatData.insert(0, new ChatData(msg: {"text": text}));
    await sendTextMsg('${widget?.id ?? widget.title}', widget.type, text);
  }

  onTapHandle(ButtonType type) {
    setState(() {
      if (type == ButtonType.voice) {
        _focusNode.unfocus();
        _isMore = false;
        _isVoice = !_isVoice;
      } else {
        _isVoice = false;
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
          _isMore = true;
        } else {
          _isMore = !_isMore;
        }
      }
      _emojiState = false;
    });
  }

  Widget edit(context, size) {
    // 计算当前的文本需要占用的行数
    TextSpan _text =
        TextSpan(text: _textController.text, style: AppStyles.ChatBoxTextStyle);

    TextPainter _tp = TextPainter(
        text: _text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left);
    _tp.layout(maxWidth: size.maxWidth);

    return ExtendedTextField(
      specialTextSpanBuilder: TextSpanBuilder(showAtBackground: true),
      onTap: () => setState(() {
        if (_focusNode.hasFocus) _emojiState = false;
      }),
      onChanged: (v) => setState(() {}),
      decoration: InputDecoration(
          border: InputBorder.none, contentPadding: const EdgeInsets.all(5.0)),
      controller: _textController,
      focusNode: _focusNode,
      maxLines: 99,
      cursorColor: const Color(AppColors.ChatBoxCursorColor),
      style: AppStyles.ChatBoxTextStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (keyboardHeight == 270.0 &&
        MediaQuery.of(context).viewInsets.bottom != 0) {
      keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    }
    var body = [
      chatData != null
          ? new ChatDetailsBody(sC: _sC, chatData: chatData)
          : new Spacer(),
      new ChatDetailsRow(
        voiceOnTap: () => onTapHandle(ButtonType.voice),
        onEmojio: () {
          if (_isMore) {
            _emojiState = true;
          } else {
            _emojiState = !_emojiState;
          }
          if (_emojiState) {
            FocusScope.of(context).requestFocus(new FocusNode());
            _isMore = false;
          }
          setState(() {});
        },
        isVoice: _isVoice,
        edit: edit,
        more: new ChatMoreIcon(
          value: _textController.text,
          onTap: () => _handleSubmittedData(_textController.text),
          moreTap: () => onTapHandle(ButtonType.more),
        ),
        id: widget.id,
        type: widget.type,
      ),
      new Visibility(
        visible: _emojiState,
        child: emojiWidget(),
      ),
      new Container(
        height: _isMore && !_focusNode.hasFocus ? keyboardHeight : 0.0,
        width: winWidth(context),
        color: Color(AppColors.ChatBoxBg),
        child: new IndicatorPageView(
          pageC: pageC,
          pages: List.generate(1, (index) {
            return new ChatMorePage(
              index: index,
              id: widget.id,
              type: widget.type,
              keyboardHeight: keyboardHeight,
            );
          }),
        ),
      ),
    ];

    var rWidget = [
      new InkWell(
        child: new Image.asset('assets/images/right_more.png'),
        onTap: () => routePush(widget.type == 2
            ? new GroupDetailsPage(
                widget?.id ?? widget.title,
                callBack: (v) {},
              )
            : new ChatInfoPage(widget.id,widget.title)),
      )
    ];

    return Scaffold(
      appBar: new ComMomBar(
          title: widget.title, rightDMActions: rWidget),
      body: new MainInputBody(
        onTap: () => setState(
          () {
            _isMore = false;
            _emojiState = false;
          },
        ),
        decoration: BoxDecoration(color: chatBg),
        child: new Column(children: body),
      ),
    );
  }

  Widget emojiWidget() {
    return new GestureDetector(
      child: new SizedBox(
        height: _emojiState ? keyboardHeight : 0,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Image.asset(EmojiUitl.instance.emojiMap["[${index + 1}]"]),
              behavior: HitTestBehavior.translucent,
              onTap: () {
                insertText("[${index + 1}]");
              },
            );
          },
          itemCount: EmojiUitl.instance.emojiMap.length,
          padding: EdgeInsets.all(5.0),
        ),
      ),
      onTap: () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    isListener = true;
    canCelListener();
    Notice.removeListenerByEvent(WeChatActions.msg());
    Notice.removeListenerByEvent(WeChatActions.groupName());
    _sC.dispose();
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin.destroy();
  }
}
