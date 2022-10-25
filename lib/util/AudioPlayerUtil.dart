import 'dart:async';
import 'dart:io';
 
import 'dart:typed_data';
 
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
 
// 单例模式
final AudioPlayerUtil audioPlayerUtil = new AudioPlayerUtil();
 
///
/// Title： Flutter提示声音工具类
/// Description：
/// 1. 单例模式
/// 2. 文件缓存管理优化
/// 3. 播放Flutter项目本地assets音频文件
/// 4. 播放网络音频文件
///
/// @version 1.0.0
/// @date 2021/12/31
///
class AudioPlayerUtil {
 
  static String SOUNDS_PATH = "assets/static/sounds/";
  static String SUCCESS_FILE = "msg.mp3";
  static String ERROR_FILE = "msg.mp3";
 
  static  AudioPlayer _audioPlayer;
  static  AudioCache _audioCache;
 
  // 工厂方法构造函数
  factory AudioPlayerUtil() => _getInstance();
 
  // instance的getter方法，singletonManager.instance获取对象
  static AudioPlayerUtil get instance => _getInstance();
 
  // 静态变量_instance，存储唯一对象
  static AudioPlayerUtil _instance = AudioPlayerUtil.internal();
 
  // 获取对象
  static AudioPlayerUtil _getInstance() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = AudioPlayerUtil.internal();
    }
    return _instance;
  }
 
  // 私有命名式构造方法，通过它实现一个类 可以有多个构造函数，
  // 子类不能继承internal
  // 不是关键字，可定义其他名字
  AudioPlayerUtil.internal() {
    // 初始化...
    _audioCache = AudioCache();
    _audioPlayer = AudioPlayer();
    print("初始化成功...");
  }
 
  // 音频文件夹, 缓存使用，path:文件
  Map<String, File> loadedFiles = {};
 
  ///播放
  loadAudioCache(String fileName) {
    // 播放给定的[fileName]。
    // 如果文件已经缓存，它会立即播放。否则，首先等待文件加载(可能需要几毫秒)。
    // 它创建一个新的实例[AudioPlayer]，所以它不会影响其他的音频播放(除非你指定一个[fixedPlayer]，在这种情况下它总是使用相同的)。
    // 返回实例，以允许以后的访问(无论哪种方式)，如暂停和恢复。
    _audioCache.play(fileName, mode: PlayerMode.LOW_LATENCY);
  }
 
  ///清空单个
  void clear(String fileName) {
    loadedFiles.remove(fileName);
  }
 
  ///清空整个
  void clearCache() {
    loadedFiles.clear();
  }
 
  /// 读取assets文件
  static Future<ByteData> _fetchAsset(String fileName) async {
    return await rootBundle.load('${SOUNDS_PATH}${fileName}');
  }
 
  /// 读取到内存
  static Future<File> _fetchToMemory(String fileName) async {
    String path = '${(await getTemporaryDirectory()).path}/${fileName}';
    final file = File(path);
    await file.create(recursive: true);
    return await file.writeAsBytes((await _fetchAsset(fileName)).buffer.asUint8List());
  }
 
  ///读取文件
  Future<File> _loadFile(String fileName) async {
    if (!loadedFiles.containsKey(fileName)) {
      // 新增到缓存
      loadedFiles[fileName] = await _fetchToMemory(fileName);
    }
    return loadedFiles[fileName];
  }
 
  /// 本地音乐文件播放
  playLocal(String fileName) async {
    // 读取文件
    File file = await _loadFile(fileName);
    // 播放音频
    // 如果[isLocal]为true， [url]必须是本地文件系统路径。
    int result = await _audioPlayer.play(file.path, isLocal: true);
    if (result == 1) {
      print('play success');
    } else {
      print('play failed');
    }
  }
 
  /// 远程音乐文件播放，localPath类似http://xxx/xxx.mp3
  playRemote(String localPath) async {
    int result = await _audioPlayer.play(localPath);
    if (result == 1) {
      print('play success');
    } else {
      print('play failed');
    }
  }
 
  playLocalSuccess() async{
    playLocal(SUCCESS_FILE);
  }
 
  playLocalError() async{
    playLocal(ERROR_FILE);
  }
 
  ///暂停
  pause() async {
    // 暂停当前播放的音频。
    // 如果你稍后调用[resume]，音频将从它的点恢复
    // 已暂停。
    int result = await _audioPlayer.pause();
    if (result == 1) {
      print('pause success');
    } else {
      print('pause failed');
    }
  }
 
  /// 调整进度 - 跳转指定时间
  /// milliseconds 毫秒
  jump(int milliseconds) async {
    //移动光标到目标位置。
    int result =
    await _audioPlayer.seek(new Duration(milliseconds: milliseconds));
    if (result == 1) {
      print('seek to success');
    } else {
      print('seek to failed');
    }
  }
 
  ///调整音量
  ///double volume 音量 0-1
  setVolume(double volume) async {
    // 设置音量(振幅)。
    // 0表示静音，1表示最大音量。0到1之间的值是线性的
    int result = await _audioPlayer.setVolume(volume);
    if (result == 1) {
      print('seek to success');
    } else {
      print('seek to failed');
    }
  }
 
  ///释放资源
  release() async {
    // 释放与该媒体播放器关联的资源。
    // 当你需要重新获取资源时，你需要重新获取资源
    // 调用[play]或[setUrl]。
    int result = await _audioPlayer.release();
    if (result == 1) {
      print('release success');
    } else {
      print('release failed');
    }
  }
}