import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_flutter/config/logger_util.dart';


/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  VideoApp({this.src});

  String src;


  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
   VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    LoggerUtil.e("videp play"+widget.src);
    if(widget.src.startsWith("http")){
      _controller = VideoPlayerController.network(
          widget.src)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }else {
        _controller = VideoPlayerController.contentUri(Uri.parse(widget.src)
        )
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
      }


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}