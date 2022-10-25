import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_flutter/config/logger_util.dart';
import 'package:wechat_flutter/config/provider_config.dart';
import 'package:wechat_flutter/config/ui.dart';
import 'package:wechat_flutter/im/login_handle.dart';
import 'package:wechat_flutter/pages/login/register_page.dart';
import 'package:wechat_flutter/pages/settings/language_page.dart';
import 'package:wechat_flutter/provider/global_model.dart';

import 'package:wechat_flutter/tools/wechat_flutter.dart';

import '../../ui/dialog/PrivacyView.dart';
import 'login_page.dart';

class LoginBeginPage extends StatefulWidget {
  @override
  _LoginBeginPageState createState() => new _LoginBeginPageState();
}

class _LoginBeginPageState extends State<LoginBeginPage> {
  Widget body(GlobalModel model) {
    var buttons = [
      new ComMomButton(
        text: S.of(context).login,
        margin: EdgeInsets.only(left: 10.0),
        width: 100.0,
        onTap: () => routePush(
            ProviderConfig.getInstance().getLoginPage(new LoginPage())),
      ),
      new ComMomButton(
          text: S.of(context).register,
          color: bgColor,
          style:
              TextStyle(fontSize: 15.0, color: Color.fromRGBO(8, 191, 98, 1.0)),
          margin: EdgeInsets.only(right: 10.0),
          onTap: () => routePush(
              ProviderConfig.getInstance().getLoginPage(new RegisterPage())),
          width: 100.0),
    ];

    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Container(
          alignment: Alignment.topRight,
          child: new InkWell(
            child: new Padding(
              padding: EdgeInsets.all(10.0),
              child: new Text(S.of(context).language,
                  style: TextStyle(color: Colors.white)),
            ),
            onTap: () => routePush(new LanguagePage()),
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: buttons,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    BuildContext c = context;

    String _data = "感谢您信任并使用好聊app！\n" +
        " \n" +
        "好聊十分重视用户权利及隐私政策并严格按照相关法律法规的要求，对《用户协议》和《隐私政策》进行了更新,特向您说明如下：\n" +
        "1.为向您提供更优质的服务，我们会收集、使用必要的信息，并会采取业界先进的安全措施保护您的信息安全；\n" +
        "2.基于您的明示授权，我们可能会获取设备号信息、包括：设备型号、操作系统版本、设备设置、设备标识符、MAC（媒体访问控制）地址、IMEI（移动设备国际身份码）、广告标识符（“IDFA”与“IDFV”）、集成电路卡识别码（“ICCD”）、软件安装列表。我们将使用三方产品（友盟、极光等）统计使用我们产品的设备数量并进行设备机型数据分析与设备适配性分析。（以保障您的账号与交易安全），且您有权拒绝或取消授权；\n" +
        "3.您可灵活设置伴伴账号的功能内容和互动权限，您可在《隐私政策》中了解到权限的详细应用说明；\n" +
        "4.未经您同意，我们不会从第三方获取、共享或向其提供您的信息；\n" +
        "5.您可以查询、更正、删除您的个人信息，我们也提供账户注销的渠道。\n" +
        " \n" +
        "请您仔细阅读并充分理解相关条款，其中重点条款已为您黑体加粗标识，方便您了解自己的权利。如您点击“同意”，即表示您已仔细阅读并同意本《用户协议》及《隐私政策》，将尽全力保障您的合法权益并继续为您提供优质的产品和服务。如您点击“不同意”，将可能导致您无法继续使用我们的产品和服务。";

    // Timer(Duration(seconds: 1), () {
    //   showGeneralDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       barrierLabel: '',
    //       transitionDuration: Duration(milliseconds: 0),
    //       pageBuilder: (BuildContext d, Animation<double> animation,
    //           Animation<double> secondaryAnimation) {
    //         return Center(
    //           child: Material(
    //             color: Colors.white,
    //             child: Container(
    //               height: MediaQuery.of(context).size.height * .6,
    //               width: MediaQuery.of(context).size.width * .8,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     height: 45,
    //                     alignment: Alignment.center,
    //                     child: Text(
    //                       '用户隐私政策概要',
    //                       style: TextStyle(
    //                           fontSize: 16, fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                   Divider(
    //                     height: 1,
    //                   ),
    //                   Expanded(
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: SingleChildScrollView(
    //                           child: PrivacyView(
    //                             data: _data,
    //                             keys: ['《用户协议》', '《隐私政策》'],
    //                             keyStyle: TextStyle(color: Colors.red),
    //                             onTapCallback: (String key) {
    //                               if (key == '《用户协议》') {
    //                                 Navigator.of(context)
    //                                     .push(MaterialPageRoute(builder: (context) {
    //                                   return WebViewPage(
    //                                       lineceurl,'用户协议');
    //                                 }));
    //                               } else if (key == '《隐私政策》') {
    //                                 Navigator.of(context)
    //                                     .push(MaterialPageRoute(builder: (context) {
    //                                   return WebViewPage(
    //                                       lineceurl,'隐私政策');
    //                                 }));
    //                               }
    //                             },
    //                           ),
    //                         ),
    //                       )),
    //                   Divider(
    //                     height: 1,
    //                   ),
    //                   Container(
    //                     height: 45,
    //                     child: Row(
    //                       children: [
    //                         Expanded(
    //                             child: GestureDetector(
    //                               child: Container(
    //                                   // color: Colors.red,
    //                                   alignment: Alignment.center,
    //                                   child: Text('不同意')),
    //                               onTap: () {
    //                                 LoggerUtil.e("aa");
    //                                 Navigator.of(c).pop();
    //                               },
    //                             )),
    //                         VerticalDivider(
    //                           width: 1,
    //                         ),
    //                         Expanded(
    //                             child: GestureDetector(
    //                               child: Container(
    //                                   alignment: Alignment.center,
    //                                   // color: Colors.green,
    //                                   child: Text('同意')),
    //                               onTap: () {
    //                                 LoggerUtil.e("aa");
    //                                 Navigator.of(c).pop();
    //                               },
    //                             )),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       });
    // });



    var bodyMain = new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bsc.webp'), fit: BoxFit.cover)),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: body(model),
    );

    return new Scaffold(body: bodyMain);
  }
}
