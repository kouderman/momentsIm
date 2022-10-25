import 'dart:async';

class PageChangeUtil {
  PageChangeUtil._internal() {
    init();
  }

  factory PageChangeUtil() => _instance;

  static final PageChangeUtil _instance = PageChangeUtil._internal();


  StreamController _controller;
  Stream _stream;

  static PageChangeUtil get instance => _instance;
  Stream get changeStream => _stream;
  StreamController get ctrl => _controller;

  void disposeStream() => _controller.close();

  void init() {
    _controller ??= StreamController.broadcast();
    _stream ??= _controller.stream;
    if(_controller.isClosed){
      _controller = null;
      _stream = null;
      init();
    }
  }

  void pushRouteDetail(dynamic data){
    init();
    _controller.sink.add(data);
  }
}

