package com.brzhang.flutter.dim;

import android.graphics.Bitmap;
import android.media.MediaMetadataRetriever;
import android.os.Environment;
import android.text.TextUtils;
import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tencent.imsdk.TIMCallBack;
import com.tencent.imsdk.TIMConnListener;
import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMFriendAllowType;
import com.tencent.imsdk.TIMFriendGenderType;
import com.tencent.imsdk.TIMFriendshipManager;
import com.tencent.imsdk.TIMGroupEventListener;
import com.tencent.imsdk.TIMGroupManager;
import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMGroupReceiveMessageOpt;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMLocationElem;
import com.tencent.imsdk.TIMLogLevel;
import com.tencent.imsdk.TIMManager;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMMessageListener;
import com.tencent.imsdk.TIMRefreshListener;
import com.tencent.imsdk.TIMSdkConfig;
import com.tencent.imsdk.TIMSnapshot;
import com.tencent.imsdk.TIMSoundElem;
import com.tencent.imsdk.TIMTextElem;
import com.tencent.imsdk.TIMUserConfig;
import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.TIMUserStatusListener;
import com.tencent.imsdk.TIMValueCallBack;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;
import com.tencent.imsdk.ext.group.TIMGroupBaseInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;
import com.tencent.imsdk.ext.group.TIMGroupMemberResult;
import com.tencent.imsdk.ext.group.TIMGroupSelfInfo;
import com.tencent.imsdk.ext.message.TIMConversationExt;
import com.tencent.imsdk.ext.message.TIMManagerExt;
import com.tencent.imsdk.ext.message.TIMMessageLocator;
import com.tencent.imsdk.ext.message.TIMUserConfigMsgExt;
import com.tencent.imsdk.friendship.TIMDelFriendType;
import com.tencent.imsdk.friendship.TIMFriend;
import com.tencent.imsdk.friendship.TIMFriendPendencyItem;
import com.tencent.imsdk.friendship.TIMFriendPendencyRequest;
import com.tencent.imsdk.friendship.TIMFriendPendencyResponse;
import com.tencent.imsdk.friendship.TIMFriendRequest;
import com.tencent.imsdk.friendship.TIMFriendResponse;
import com.tencent.imsdk.friendship.TIMFriendResult;
import com.tencent.imsdk.friendship.TIMPendencyType;
import com.tencent.imsdk.session.SessionWrapper;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * DimPlugin
 */
public class DimPlugin implements MethodCallHandler, EventChannel.StreamHandler {
    private static final String TAG = "DimPlugin";
    private Registrar registrar;
    private EventChannel.EventSink eventSink;
    private TIMMessageListener timMessageListener;
    private TIMRefreshListener timRefreshListener;

    public DimPlugin(Registrar registrar) {
        this.registrar = registrar;
        //???????????????
        timMessageListener = new TIMMessageListener() {
            @Override
            public boolean onNewMessages(List<TIMMessage> list) {
                if (list != null && list.size() > 0) {
                    List<Message> messages = new ArrayList<>();
                    for (TIMMessage timMessage : list) {
                        messages.add(new Message(timMessage));
                    }
                    if (eventSink != null) {
                        eventSink.success(new Gson().toJson(messages, new TypeToken<Collection<Message>>() {
                        }.getType()));
                    }

                }
                return false;
            }
        };
        //???????????????
        timRefreshListener = new TIMRefreshListener() {
            @Override
            public void onRefresh() {
                if (eventSink != null) {
                    eventSink.success("[]");
                }

            }

            @Override
            public void onRefreshConversation(List<TIMConversation> conversations) {
//                if (conversations != null && conversations.size() > 0) {
//                    eventSink.success(new Gson().toJson(conversations, new TypeToken<Collection<TIMConversation>>() {
//                    }.getType()));
//                }
            }
        };
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel =
                new MethodChannel(registrar.messenger(), "dim_method");
        final EventChannel eventChannel =
                new EventChannel(registrar.messenger(), "dim_event");
        final DimPlugin dimPlugin = new DimPlugin(registrar);
        channel.setMethodCallHandler(dimPlugin);
        eventChannel.setStreamHandler(dimPlugin);
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("init")) {
            int appid = call.argument("appid");
            //????????? IM SDK ????????????
            //???????????????????????????
            if (SessionWrapper.isMainProcess(registrar.context())) {
                TIMSdkConfig config = new TIMSdkConfig(appid)
                        .enableLogPrint(true)
                        .setLogLevel(TIMLogLevel.DEBUG)
                        .setLogPath(Environment.getExternalStorageDirectory().getPath() + "/justfortest/");

                //????????? SDK
                TIMManager.getInstance().init(registrar.context(), config);


                //??????????????????,???????????????????????????????????? TIMManager ????????? setUserConfig ???????????????????????????????????????????????????
                TIMUserConfig userConfig = new TIMUserConfig()
                        //???????????????????????????????????????
                        .setUserStatusListener(new TIMUserStatusListener() {
                            @Override
                            public void onForceOffline() {
                                //????????????????????????
                                Log.i(TAG, "onForceOffline");
                            }

                            @Override
                            public void onUserSigExpired() {
                                //???????????????????????????????????? userSig ???????????? IM SDK
                                Log.i(TAG, "onUserSigExpired");
                            }
                        })
                        //?????????????????????????????????
                        .setConnectionListener(new TIMConnListener() {
                            @Override
                            public void onConnected() {
                                Log.i(TAG, "onConnected");
                            }

                            @Override
                            public void onDisconnected(int code, String desc) {
                                Log.i(TAG, "onDisconnected");
                            }

                            @Override
                            public void onWifiNeedAuth(String name) {
                                Log.i(TAG, "onWifiNeedAuth");
                            }
                        })
                        //???????????????????????????
                        .setGroupEventListener(new TIMGroupEventListener() {
                            @Override
                            public void onGroupTipsEvent(TIMGroupTipsElem elem) {
                                Log.i(TAG, "onGroupTipsEvent, type: " + elem.getTipsType());
                            }
                        })
                        //???????????????????????????
                        .setRefreshListener(timRefreshListener);

                //????????????????????????
                userConfig = new TIMUserConfigMsgExt(userConfig)
                        .enableAutoReport(true)
                        //????????????????????????
                        .enableReadReceipt(true);
                //?????????????????????????????????????????????
                TIMManager.getInstance().setUserConfig(userConfig);

                TIMManager.getInstance().removeMessageListener(timMessageListener);
                TIMManager.getInstance().addMessageListener(timMessageListener);

                result.success("init succ");
            } else {
                result.success("init failed ,not in main process");
            }
        } else if (call.method.equals("im_login")) {
            if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
                result.error("login failed. ", "user is login", "user is already login ,you should login out first");
                return;
            }
            String identifier = call.argument("identifier");
            String userSig = call.argument("userSig");
            if (userSig == null) {
                userSig = GenerateTestUserSig.genTestUserSig(identifier);
            }
            // identifier???????????????userSig ?????????????????????
            TIMManager.getInstance().login(identifier, userSig, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e("login", "onError -----------" + code + "--" + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    Log.e("login", "onSuccess -----------");
                    result.success("login succ");
                }
            });
        } else if (call.method.equals("im_logout")) {
            TIMManager.getInstance().logout(new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    result.success("logout success");
                }
            });
        } else if (call.method.equals("sdkLogout")) {
            //??????
            TIMManager.getInstance().logout(new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TAG, "logout failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    //????????????
                    result.success("logout success");
                }
            });
        } else if (call.method.equals("getConversations")) {
            List<TIMConversation> list = TIMManagerExt.getInstance().getConversationList();
            if (list != null && list.size() > 0) {
                result.success(new Gson().toJson(list, new TypeToken<Collection<TIMConversation>>() {
                }.getType()));
            } else {
                result.success("[]");
            }
        } else if (call.method.equals("delConversation")) {
            String identifier = call.argument("identifier");
            int type = call.argument("type");
            TIMManagerExt.getInstance().deleteConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);
            result.success("delConversation success");
        } else if (call.method.equals("getMessages")) {
            String identifier = call.argument("identifier");
            int count = call.argument("count");
            Log.e(TAG, "??????" + count + "?????????");
            int type = call.argument("ctype");
//            TIMMessage lastMsg = call.argument("lastMsg");
            //????????????????????????
            TIMConversation con = TIMManager.getInstance().getConversation(type == 2 ? TIMConversationType.Group : TIMConversationType.C2C, identifier);
            TIMConversationExt conExt = new TIMConversationExt(con);

//????????????????????????
            conExt.getMessage(count, //???????????????????????? 100 ?????????
                    null, //???????????????????????????????????? - ???????????????????????????????????????
                    new TIMValueCallBack<List<TIMMessage>>() {//????????????
                        @Override
                        public void onError(int code, String desc) {//??????????????????
                            Log.d(TAG, "get message failed. code: " + code + " errmsg: " + desc);
                            result.error(desc, String.valueOf(code), null);
                        }

                        @Override
                        public void onSuccess(List<TIMMessage> msgs) {//??????????????????
                            //?????????????????????
                            if (msgs != null && msgs.size() > 0) {
                                List<Message> messages = new ArrayList<>();
                                for (TIMMessage timMessage : msgs) {
                                    messages.add(new Message(timMessage));
                                }
                                result.success(new Gson().toJson(messages, new TypeToken<Collection<Message>>() {
                                }.getType()));
                            } else {
                                result.success("[]");
                            }
                        }
                    });
        } else if (call.method.equals("sendTextMessages")) {
            String identifier = call.argument("identifier");
            String content = call.argument("content");
            int type = call.argument("type");
            TIMMessage msg = new TIMMessage();
            msg.setTimestamp(System.currentTimeMillis());

            //??????????????????
            TIMTextElem elem = new TIMTextElem();
            elem.setText(content);

            //???elem???????????????
            if (msg.addElement(elem) != 0) {
                Log.d(TAG, "addElement failed");
                return;
            }
            TIMConversation conversation = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);

            //????????????
            conversation.sendMessage(msg, new TIMValueCallBack<TIMMessage>() {//??????????????????
                @Override
                public void onError(int code, String desc) {//??????????????????
                    Log.d(TAG, "send message failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(TIMMessage msg) {//??????????????????
                    Log.e(TAG, "sendTextMessages ok");
                    result.success("sendTextMessages ok");
                }
            });
        } else if (call.method.equals("sendImageMessages")) {
            String identifier = call.argument("identifier");
            String iamgePath = call.argument("image_path");
            int type = call.argument("type");

            //??????????????????
            TIMMessage msg = new TIMMessage();
            msg.setTimestamp(System.currentTimeMillis());

//????????????
            TIMImageElem elem = new TIMImageElem();
//            elem.setPath(Environment.getExternalStorageDirectory() + "/DCIM/Camera/1.jpg");
            elem.setPath(iamgePath);
//??? elem ???????????????
            if (msg.addElement(elem) != 0) {
                Log.d(TAG, "addElement failed");
                return;
            }
            TIMConversation conversation = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);
//????????????
            conversation.sendMessage(msg, new TIMValueCallBack<TIMMessage>() {//??????????????????
                @Override
                public void onError(int code, String desc) {//??????????????????
                    Log.d(TAG, "send message failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(TIMMessage msg) {//??????????????????
                    Log.e(TAG, "SendMsg ok");
                    result.success("SendMsg ok");
                }
            });
        } else if (call.method.equals("sendSoundMessages")) {
            String identifier = call.argument("identifier");
            String sound_path = call.argument("sound_path");
            int duration = call.argument("duration");
            int type = call.argument("type");

            //??????????????????
            TIMMessage msg = new TIMMessage();
            msg.setTimestamp(System.currentTimeMillis());

//????????????
            TIMSoundElem elem = new TIMSoundElem();
            elem.setPath(sound_path);
            elem.setDuration(duration);
//??? elem ???????????????
            if (msg.addElement(elem) != 0) {
                Log.d(TAG, "addElement failed");
                return;
            }
            TIMConversation conversation = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);

//????????????
            conversation.sendMessage(msg, new TIMValueCallBack<TIMMessage>() {//??????????????????
                @Override
                public void onError(int code, String desc) {//??????????????????
                    Log.d(TAG, "send message failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(TIMMessage msg) {//??????????????????
                    Log.e(TAG, "sendSoundMessages ok");
                    result.success("sendSoundMessages ok");
                }
            });
        } else if (call.method.equals("buildVideoMessage")) {

            String identifier = call.argument("identifier");

            String videoPath = call.argument("videoPath");

            int width = call.argument("width");
            int height = call.argument("height");
            int duration = call.argument("duration");
            int type = call.argument("type");

            //??????????????????
            TIMMessage msg = new TIMMessage();
            msg.setTimestamp(System.currentTimeMillis());

            TIMVideoElem ele = new TIMVideoElem();

            TIMVideo video = new TIMVideo();
            video.setDuaration(duration / 1000);
            video.setType("mp4");
            TIMSnapshot snapshot = new TIMSnapshot();

            MediaMetadataRetriever media = new MediaMetadataRetriever();
            media.setDataSource(videoPath);

            snapshot.setWidth(width);
            snapshot.setHeight(height);

            ele.setSnapshot(snapshot);
            ele.setVideo(video);
            ele.setVideoPath(videoPath);
            Bitmap bitmap = media.getFrameAtTime();
            File file = new File(registrar.context().getExternalFilesDir(null).getPath() + "/mfw.png");

            try {
                file.createNewFile();
                //???????????????
                FileOutputStream fileOutputStream = new FileOutputStream(file);
                //??????????????????????????????png?????????Bitmap.CompressFormat.PNG????????????jpg??????Bitmap.CompressFormat.JPEG,?????????100%??????????????????
                bitmap.compress(Bitmap.CompressFormat.PNG, 50, fileOutputStream);
                //?????????????????????????????????????????????
                fileOutputStream.flush();
                //????????????????????????
                fileOutputStream.close();
                //???????????????????????????????????????????????????????????????????????????
                ele.setSnapshotPath(registrar.context().getExternalFilesDir(null).getPath() + "/mfw.png");
                Log.d(TAG, "?????????????????? " + registrar.context().getExternalFilesDir(null).getPath() + "/mfw.png");
            } catch (Exception e) {
                e.printStackTrace();
                Log.d(TAG, e.getMessage());
            }

            msg.addElement(ele);
            if (msg.addElement(ele) != 0) {
                Log.d(TAG, "addElement failed");
                return;
            }

            TIMConversation conversation = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);

//????????????
            conversation.sendMessage(msg, new TIMValueCallBack<TIMMessage>() {//????????????????????????
                @Override
                public void onError(int code, String desc) {//????????????????????????
                    Log.d(TAG, "send buildVideoMessage failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(TIMMessage msg) { //????????????????????????
                    Log.e(TAG, "buildVideoMessage ok");
                    result.success("buildVideoMessage ok");
                }
            });

        } else if (call.method.equals("sendLocation")) {

            String identifier = call.argument("identifier");
            double lat = call.argument("lat");
            double lng = call.argument("lng");
            String desc = call.argument("desc");

            TIMConversation conversation = TIMManager.getInstance().getConversation(TIMConversationType.C2C, identifier);
            //??????????????????
            TIMMessage msg = new TIMMessage();

//??????????????????
            TIMLocationElem elem = new TIMLocationElem();
            elem.setLatitude(lat);   //????????????
            elem.setLongitude(lng);   //????????????
            elem.setDesc(desc);

//???elem???????????????
            if (msg.addElement(elem) != 0) {
                Log.d(TAG, "addElement failed");
                return;
            }
//????????????
            conversation.sendMessage(msg, new TIMValueCallBack<TIMMessage>() {//??????????????????
                @Override
                public void onError(int code, String desc) {//??????????????????
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(TIMMessage msg) {//??????????????????
                    Log.e(TAG, "Send location ok");
                    result.success("sendLocation ok");
                }
            });

        } else if (call.method.equals("post_data_test")) {
            Log.e(TAG, "onMethodCall() called with: call = [" + call + "], result = [" + result + "]");
            eventSink.success("hahahahha  I am from listener");
        } else if (call.method.equals("addFriend")) {
            //??????????????????
            //??????????????????
            String identifier = call.argument("identifier");
            TIMFriendRequest timFriendRequest = new TIMFriendRequest(identifier);
            timFriendRequest.setAddWording("????????????!");
            timFriendRequest.setAddSource("android");
            TIMFriendshipManager.getInstance().addFriend(timFriendRequest, new TIMValueCallBack<TIMFriendResult>() {
                @Override
                public void onError(int code, String desc) {
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(TIMFriendResult timFriendResult) {
                    result.success("addFriend success");
                }
            });
        } else if (call.method.equals("delFriend")) {
            //?????????????????? test_user
            String identifier = call.argument("identifier");

            List<String> identifiers = new ArrayList<>();
            identifiers.add(identifier);
            TIMFriendshipManager.getInstance().deleteFriends(identifiers, TIMDelFriendType.TIM_FRIEND_DEL_BOTH, new TIMValueCallBack<List<TIMFriendResult>>() {
                @Override
                public void onError(int code, String desc) {
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(List<TIMFriendResult> timUserProfiles) {
                    result.success("deleteFriends success");
                }
            });
        } else if (call.method.equals("listFriends")) {
            TIMFriendshipManager.getInstance().getFriendList(new TIMValueCallBack<List<TIMFriend>>() {
                @Override
                public void onError(int code, String desc) {
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(List<TIMFriend> timFriends) {
                    List<TIMUserProfile> userList = new ArrayList<>();
                    for (TIMFriend timFriend : timFriends) {
                        userList.add(timFriend.getTimUserProfile());
                    }
                    result.success(new Gson().toJson(userList, new TypeToken<Collection<TIMUserProfile>>() {
                    }.getType()));
                }
            });
        } else if (call.method.equals("opFriend")) {//????????????
            //??????????????????
            String identifier = call.argument("identifier");
            String opTypeStr = call.argument("opTypeStr");
            TIMFriendResponse timFriendAddResponse = new TIMFriendResponse();
            timFriendAddResponse.setIdentifier(identifier);
            if (opTypeStr.toUpperCase().trim().equals("Y")) {
                timFriendAddResponse.setResponseType(TIMFriendResponse.TIM_FRIEND_RESPONSE_AGREE_AND_ADD);
            } else {
                timFriendAddResponse.setResponseType(TIMFriendResponse.TIM_FRIEND_RESPONSE_REJECT);
            }
            TIMFriendshipManager.getInstance().doResponse(timFriendAddResponse, new TIMValueCallBack<TIMFriendResult>() {
                @Override
                public void onError(int i, String s) {
                    result.error(s, String.valueOf(i), null);
                }

                @Override
                public void onSuccess(TIMFriendResult timFriendResult) {
                    result.success(timFriendResult.getIdentifier());
                }
            });
        } else if (call.method.equals("getUsersProfile")) {
            List<String> users = call.argument("users");
            //??????????????????
            TIMFriendshipManager.getInstance().getUsersProfile(users, true, new TIMValueCallBack<List<TIMUserProfile>>() {
                @Override
                public void onError(int code, String desc) {
                    //????????? code ??????????????? desc????????????????????????????????????
                    //????????? code ???????????????????????????
                    Log.e(TAG, "getUsersProfile failed: " + code + " desc");
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(List<TIMUserProfile> timUserProfiles) {
                    Log.e(TAG, "getUsersProfile succ");
                    if (timUserProfiles != null && timUserProfiles.size() > 0) {
                        result.success(new Gson().toJson(timUserProfiles, new TypeToken<Collection<TIMUserProfile>>() {
                        }.getType()));
                    } else {
                        result.success("[]");
                    }

                }
            });
        } else if (call.method.equals("setUsersProfile")) {

            String nick = call.argument("nick");
            int gender = call.argument("gender");
            String faceUrl = call.argument("faceUrl");
            HashMap<String, Object> profileMap = new HashMap<>();
            profileMap.put(TIMUserProfile.TIM_PROFILE_TYPE_KEY_NICK, nick);
            profileMap.put(TIMUserProfile.TIM_PROFILE_TYPE_KEY_GENDER, gender == 1 ? TIMFriendGenderType.GENDER_MALE : TIMFriendGenderType.GENDER_FEMALE);
            profileMap.put(TIMUserProfile.TIM_PROFILE_TYPE_KEY_FACEURL, faceUrl);
            TIMFriendshipManager.getInstance().modifySelfProfile(profileMap, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modifySelfProfile failed: " + code + " desc" + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "modifySelfProfile success");
                    result.success("setUsersProfile succ");
                }
            });
        } else if (call.method.equals("getCurrentLoginUser")) {
            result.success(TIMManager.getInstance().getLoginUser());
        } else if (call.method.equals("im_autoLogin")) {
            if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
                result.error("login failed. ", "user is login", "user is already login ,you should login out first");
                return;
            }
            String identifier = call.argument("identifier");
            // identifier???????????????userSig ?????????????????????
            TIMManager.getInstance().autoLogin(identifier, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "autoLogin failed: " + code + " desc" + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "autoLogin succ");
                    result.success("autoLogin succ");
                }
            });
        } else if (call.method.equals("deleteConversationAndLocalMsg")) {

            int type = call.argument("type");
            String identifier = call.argument("identifier");

            TIMManager.getInstance().deleteConversationAndLocalMsgs(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);
            result.success("???????????????" + identifier);
        } else if (call.method.equals("getUnreadMessageNum")) {
            int type = call.argument("type");
            String identifier = call.argument("identifier");
            //????????????????????????
            TIMConversation con = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group, identifier);
//?????????????????????
            long num = con.getUnreadMessageNum();
            Log.d(TAG, "unread msg num: " + num);
            result.success(num);

        } else if (call.method.equals("setReadMessage")) {
            int type = call.argument("type");
            String identifier = call.argument("identifier");
            TIMConversation conversation = TIMManager.getInstance().getConversation(
                    type == 1 ? TIMConversationType.C2C : TIMConversationType.Group,    //?????????????????????
                    identifier);                      //????????????????????????
//??????????????????????????????????????????
            conversation.setReadMessage(null, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "setReadMessage failed, code: " + code + "|desc: " + desc);
                    result.error(desc, "error" + code, null);
                }

                @Override
                public void onSuccess() {
                    Log.d(TAG, "setReadMessage succ");
                    result.success("setReadMessage succ");
                }
            });
        } else if (call.method.equals("deleteGroup")) {
            String groupId = call.argument("groupId");

            //????????????
            TIMGroupManager.getInstance().deleteGroup(groupId, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    //????????? code ??????????????? desc????????????????????????????????????
                    //????????? code ???????????????????????????
                    Log.d(TAG, "login failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, "login failed. code: " + code + " errmsg: ", null);
                }

                @Override
                public void onSuccess() {
                    //??????????????????
                    result.success("??????????????????");
                }
            });
        } else if (call.method.equals("modifyGroupOwner")) {
            String groupId = call.argument("groupId");
            String id = call.argument("identifier");

            //????????????
            TIMGroupManager.getInstance().modifyGroupOwner(groupId,id, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    //????????? code ??????????????? desc????????????????????????????????????
                    //????????? code ???????????????????????????
                    Log.d(TAG, "login failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, "login failed. code: " + code + " errmsg: ", null);
                }

                @Override
                public void onSuccess() {
                    //??????????????????
                    result.success("??????????????????");
                }
            });

        } else if (call.method.equals("modifyGroupName")) {
            String groupId = call.argument("groupId");
            String setGroupName = call.argument("setGroupName");

            TIMGroupManager.ModifyGroupInfoParam param = new TIMGroupManager.ModifyGroupInfoParam(groupId);
            param.setGroupName(setGroupName);
            TIMGroupManager.getInstance().modifyGroupInfo(param, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modify group info failed, code:" + code + "|desc:" + desc);
                    result.error(desc, "modify group info failed, code:" + code, null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "modify group info succ");
                    result.success("modify group info succ");
                }
            });
        } else if (call.method.equals("modifyGroupIntroduction")) {
            String groupId = call.argument("groupId");
            String setIntroduction = call.argument("setIntroduction");

            TIMGroupManager.ModifyGroupInfoParam param = new TIMGroupManager.ModifyGroupInfoParam(groupId);
            param.setIntroduction(setIntroduction);
            TIMGroupManager.getInstance().modifyGroupInfo(param, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modify group info failed, code:" + code + "|desc:" + desc);
                    result.error(desc, "modify group info failed, code:" + code, null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "modify group info succ");
                    result.success("modify group info succ");
                }
            });
        } else if (call.method.equals("modifyGroupNotification")) {
            String groupId = call.argument("groupId");
            String notification = call.argument("notification");
            String time = call.argument("time");

            TIMGroupManager.ModifyGroupInfoParam param = new TIMGroupManager.ModifyGroupInfoParam(groupId);
            param.setNotification(notification);
            param.setIntroduction(time);
            TIMGroupManager.getInstance().modifyGroupInfo(param, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modify group info failed, code:" + code + "|desc:" + desc);
                    result.error(desc, "modify group info failed, code:" + code, null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "modify group info succ");
                    result.success("modify group info succ");
                }
            });
        } else if (call.method.equals("setReceiveMessageOption")) {
            String groupId = call.argument("groupId");
            String identifier = call.argument("identifier");
            int type = call.argument("type");

            TIMGroupManager.ModifyMemberInfoParam param = new TIMGroupManager.ModifyMemberInfoParam(groupId, identifier);
            param.setReceiveMessageOpt(type == 1 ? TIMGroupReceiveMessageOpt.ReceiveAndNotify : TIMGroupReceiveMessageOpt.ReceiveNotNotify);

            TIMGroupManager.getInstance().modifyMemberInfo(param, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modifyMemberInfo failed, code:" + code + "|msg: " + desc);
                    result.error(desc, "modifyMemberInfo failed, code:" + code, null);
                }

                @Override
                public void onSuccess() {
                    Log.d(TAG, "modifyMemberInfo succ");
                    result.success("modifyMemberInfo succ");
                }
            });
        } else if (call.method.equals("getPendencyList")) {
            final TIMFriendPendencyRequest timFriendPendencyRequest = new TIMFriendPendencyRequest();
            timFriendPendencyRequest.setTimPendencyGetType(TIMPendencyType.TIM_PENDENCY_COME_IN);
            timFriendPendencyRequest.setSeq(0);
            timFriendPendencyRequest.setTimestamp(0);
            timFriendPendencyRequest.setNumPerPage(10);
            TIMFriendshipManager.getInstance().getPendencyList(timFriendPendencyRequest, new TIMValueCallBack<TIMFriendPendencyResponse>() {
                @Override
                public void onError(int i, String s) {
                    Log.e(TAG, "getPendencyList err code = " + i + ", desc = " + s);
                }

                @Override
                public void onSuccess(TIMFriendPendencyResponse timFriendPendencyResponse) {
                    List<TIMFriendPendencyItem> items = timFriendPendencyResponse.getItems();

                    List mData = new ArrayList<>();

                    Iterator var3 = items.iterator();

                    while (var3.hasNext()) {
                        TIMFriendPendencyItem timFriendPendencyItem = (TIMFriendPendencyItem) var3.next();
                        mData.add("{'id':'" + timFriendPendencyItem.getIdentifier() + "',"
                                + "'addSource':'" + timFriendPendencyItem.getAddSource() + "',"
                                + "'wording':'" + timFriendPendencyItem.getAddWording() + "',"
                                + "'nickname':'" + timFriendPendencyItem.getNickname() + "',"
                                + "'time':'" + timFriendPendencyItem.getAddTime() + "',"
                                + "'type':'" + timFriendPendencyItem.getType() + "',"
                                + "}"
                        );
                    }
                    Log.i(TAG, "getPendencyList success result = " + timFriendPendencyResponse.toString());
                    result.success(mData.toString());
                }
            });
        } else if (call.method.equals("getSelfProfile")) {
            //???????????????????????????????????????
            TIMFriendshipManager.getInstance().getSelfProfile(new TIMValueCallBack<TIMUserProfile>() {
                @Override
                public void onError(int code, String desc) {
                    //????????? code ??????????????? desc????????????????????????????????????
                    //????????? code ???????????????????????????
                    Log.e(TAG, "getSelfProfile failed: " + code + " desc");
                    result.error(desc, "getSelfProfile failed, code:" + code, null);
                }

                @Override
                public void onSuccess(TIMUserProfile resultS) {
                    Log.e(TAG, "getSelfProfile succ");
                    Log.e(TAG, "identifier: " + resultS.getIdentifier() + " nickName: " + resultS.getNickName()
                            + " allow: " + resultS.getAllowType());
                    result.success("identifier: " + resultS.getIdentifier() + " nickName: " + resultS.getNickName()
                            + " allow: " + resultS.getAllowType());
                }
            });
        } else if (call.method.equals("setAddMyWay")) {
            int type = call.argument("type");
            HashMap<String, Object> profileMap = new HashMap<>();
            profileMap.put(TIMUserProfile.TIM_PROFILE_TYPE_KEY_ALLOWTYPE, type == 1 ? TIMFriendAllowType.TIM_FRIEND_NEED_CONFIRM : TIMFriendAllowType.TIM_FRIEND_ALLOW_ANY);
            TIMFriendshipManager.getInstance().modifySelfProfile(profileMap, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modifySelfProfile failed: " + code + " desc" + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "setAddMyWay success");
                    result.success("setsetAddMyWay succ");
                }
            });
        } else if (call.method.equals("im_autoLogin")) {
            if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
                result.error("login failed. ", "user is login", "user is already login ,you should login out first");
                return;
            }
            String identifier = call.argument("identifier");
            // identifier???????????????userSig ?????????????????????
            TIMManager.getInstance().autoLogin(identifier, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "autoLogin failed: " + code + " desc" + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "autoLogin succ");
                    result.success("autoLogin succ");
                }
            });
        } else if (call.method.equals("getLoginUser")) {
            if (!TextUtils.isEmpty(TIMManager.getInstance().getLoginUser())) {
                result.error("login failed. ", "user is login", "user is already login ,you should login out first");
                return;
            }
            result.success(TIMManager.getInstance().getLoginUser());
        } else if (call.method.equals("initStorage")) {
            String identifier = call.argument("identifier");

            TIMManager.getInstance().initStorage(identifier, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TAG, "initStorage failed. code: " + code + " errmsg: " + desc);
                    result.error("initStorage", " failed. code: " + code, null);
                }

                @Override
                public void onSuccess() {
                    result.success("initStorage success");
                }
            });
        } else if (call.method.equals("getSelfGroupNameCard")) {
            String groupId = call.argument("groupId");

            TIMGroupManager.getInstance().getSelfInfo(
                    groupId, new TIMValueCallBack<TIMGroupSelfInfo>() {
                        @Override
                        public void onError(int i, String s) {
                            Log.d(TAG, "getSelfGroupNameCard error. code: " + i + " errmsg: " + s);
                            result.error("?????????????????????????????????", "?????????" + i, s);
                        }

                        @Override
                        public void onSuccess(TIMGroupSelfInfo timGroupSelfInfo) {
                            Log.d(TAG, "getSelfGroupNameCard success");
                            result.success(timGroupSelfInfo.getNameCard());
                        }
                    }
            );
        } else if (call.method.equals("setGroupNameCard")) {
            String groupId = call.argument("groupId");
            String identifier = call.argument("identifier");
            String name = call.argument("name");

            TIMGroupManager.ModifyMemberInfoParam param = new TIMGroupManager.ModifyMemberInfoParam(groupId, identifier);
            param.setNameCard(name);

            TIMGroupManager.getInstance().modifyMemberInfo(param, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "modifyMemberInfo failed, code:" + code + "|msg: " + desc);
                }

                @Override
                public void onSuccess() {
                    Log.d(TAG, "modifyMemberInfo succ");
                    result.success("modifyMemberInfo succ");
                }
            });
        } else if (call.method.equals("revokeMessage")) {
            int type = call.argument("type");
            String conversationId = call.argument("conversationId");

            TIMConversation timConversation = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group,
                    conversationId);
            TIMMessage msg = new TIMMessage();
//            msg.setCustomInt();
            timConversation.revokeMessage(msg, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TAG, "revokeMessage failed. code: " + code + " errmsg: " + desc);
                    result.error("????????????", "?????????" + code, desc);
                }

                @Override
                public void onSuccess() {
                    Log.d(TAG, "????????????");
                    result.success("????????????");
                }
            });
        } else if (call.method.equals("findMessages")) {
            int type = call.argument("type");
            String conversationId = call.argument("conversationId");

            TIMConversation timConversation = TIMManager.getInstance().getConversation(type == 1 ? TIMConversationType.C2C : TIMConversationType.Group,
                    conversationId);
            List<TIMMessageLocator> locators = new ArrayList<>();
//            for(int i = 0;i< locators.size();i++) {
//                TIMMessageLocator timMessageLocator = locators.get(i);
//
//                timMessageLocator.toString();
//            }
            timConversation.findMessages(locators, new TIMValueCallBack<List<TIMMessage>>() {
                @Override
                public void onError(int i, String s) {

                }

                @Override
                public void onSuccess(List<TIMMessage> timMessages) {

                }
            });
        } else if (call.method.equals("getGroupMembersInfo")) {
            String groupId = call.argument("groupId");
            List<String> userIDs = call.argument("userIDs");

            TIMGroupManager.getInstance().getGroupMembersInfo(
                    groupId, userIDs, new TIMValueCallBack<List<TIMGroupMemberInfo>>() {
                        @Override
                        public void onError(int i, String s) {
                            Log.d(TAG, "failed. code: " + i + " errmsg: " + s);
                            result.error(null, "failed. code: ", i);
                        }

                        @Override
                        public void onSuccess(List<TIMGroupMemberInfo> timGroupMemberInfos) {
                            List<String> mData = new ArrayList<>();
                            for (TIMGroupMemberInfo infoIM : timGroupMemberInfos) {
                                mData.add("{'user':'" + infoIM.getUser() + "'," +
                                        "'joinTime':'" + infoIM.getJoinTime() + "'," +
                                        "'nameCard':'" + infoIM.getNameCard() + "'," +
                                        "'msgFlag':'" + infoIM.getMsgFlag() + "'," +
                                        "'msgSeq':'" + infoIM.getMsgSeq() + "'," +
                                        "'silenceSeconds':'" + infoIM.getSilenceSeconds() + "'," +
                                        "'tinyId':'" + infoIM.getTinyId() + "'," +
                                        "'role':'" + infoIM.getRole() + "'}");
                            }
                            result.success(mData.toString());
                        }
                    }
            );
        } else if (call.method.equals("getGroupInfoList")) {
            List<String> groupID = call.argument("groupID");

            TIMGroupManager.getInstance().getGroupInfo(groupID, new TIMValueCallBack<List<TIMGroupDetailInfoResult>>() {
                @Override
                public void onError(final int code, final String desc) {
                    Log.e(TAG, "loadGroupPublicInfo failed, code: " + code + "|desc: " + desc);
                    result.error(desc, "error Code" + code, null);
                }

                @Override
                public void onSuccess(final List<TIMGroupDetailInfoResult> timGroupDetailInfoResults) {
                    List<String> mData = new ArrayList<>();

                    if (timGroupDetailInfoResults.size() > 0) {
                        TIMGroupDetailInfoResult info = timGroupDetailInfoResults.get(0);
                        mData.add("{'faceUrl': " + "'" + info.getFaceUrl() + "'");
                        mData.add("'groupId': " + "'" + info.getGroupId() + "'");
                        mData.add("'groupIntroduction': " + "'" + info.getGroupIntroduction() + "'");
                        mData.add("'groupName': " + "'" + info.getGroupName() + "'");
                        mData.add("'groupNotification': " + "'" + info.getGroupNotification() + "'");
                        mData.add("'groupOwner': " + "'" + info.getGroupOwner() + "'");
                        mData.add("'groupType': " + "'" + info.getGroupType() + "'");
                        mData.add("'lastInfoTime': " + "'" + info.getLastInfoTime() + "'");
                        mData.add("'lastMsgTime': " + "'" + info.getLastMsgTime() + "'");
                        mData.add("'createTime': " + "'" + info.getCreateTime() + "'");
                        mData.add("'memberNum': " + "'" + info.getMemberNum() + "'");
                        mData.add("'maxMemberNum': " + "'" + info.getMaxMemberNum() + "'");
                        mData.add("'OnlineMemberNum': " + "'" + info.getOnlineMemberNum() + "'" + "}");
                    }
                    result.success(mData.toString());
                }
            });
        } else if (call.method.equals("getGroupList")) {
            //????????????
            TIMValueCallBack<List<TIMGroupBaseInfo>> cb = new TIMValueCallBack<List<TIMGroupBaseInfo>>() {
                @Override
                public void onError(int code, String desc) {
                    //????????? code ??????????????? desc????????????????????????????????????
                    //????????? code ?????????????????????????????
                    Log.e(TAG, "get gruop list failed: " + code + " desc");
//                    result.error(desc, "error Code" + code, null);
                }

                @Override
                public void onSuccess(List<TIMGroupBaseInfo> timGroupInfos) {//?????????????????????????????????
                    Log.d(TAG, "get gruop list succ");
                    List<String> mData = new ArrayList<>();
                    for (TIMGroupBaseInfo info : timGroupInfos) {
                        mData.add("{'groupId':'" + info.getGroupId() + "',"
                                + "'groupName':'" + info.getGroupName() + "',"
                                + "'getFaceUrl':'" + info.getFaceUrl() + "'}");

                        Log.d(TAG, "group id: " + info.getGroupId() +
                                " group name: " + info.getGroupName() +
                                " getFaceUrl: " + info.getFaceUrl());

                    }
                    result.success(mData.toString());
                }
            };

//??????????????????????????????
            TIMGroupManager.getInstance().getGroupList(cb);
        } else if (call.method.equals("createGroupChat")) {
            String name = call.argument("name");
            List<String> personList = call.argument("personList");

            //???????????????????????????????????? ID
            final TIMGroupManager.CreateGroupParam param = new TIMGroupManager.CreateGroupParam("Private", name);
            List<TIMGroupMemberInfo> infoS = new ArrayList<>();

            for (int i = 0; i < personList.size(); i++) {
                TIMGroupMemberInfo memberInfo = new TIMGroupMemberInfo(personList.get(i));
                infoS.add(memberInfo);
            }

            param.setMembers(infoS);
            param.setNotification("welcome to our group");

//            NineCellBitmapUtil nineCellBitmapUtil;
//
//            String[] urlArray = {
//                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538451017&di=dd252d5e4594f786d34891fb6be826ff&imgtype=jpg&er=1&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201311%2F28%2F20131128101128_JZUaM.jpeg",
//                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537856300317&di=e4aebfba49e34aa5bd8de8346b268229&imgtype=0&src=http%3A%2F%2Fs9.knowsky.com%2Fbizhi%2Fl%2F35001-45000%2F20095294542896291195.jpg",
//                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537856300315&di=8def4a51ac362ffa7602ca768d76c982&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ff9198618367adab44ce126ab8bd4b31c8701e420.jpg",
//                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537345745067&di=d51264f2b354863c865a1da4b6672d90&imgtype=0&src=http%3A%2F%2Fpic40.nipic.com%2F20140426%2F6608733_175243397000_2.jpg",
//                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3394638573,2701566035&fm=26&gp=0.jpg",
//                    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2758635669,3034136689&fm=26&gp=0.jpg",
//                    "http://t.cn/EvHONPF",
//                    "http://t.cn/EvHOTa9",
//                    "http://t.cn/EvHO38y",
//            };
//            List<String> imgList = new ArrayList<>();
//            // ???????????????????????????????????????????????????????????????1000??????????????????????????????20??????
//            nineCellBitmapUtil = NineCellBitmapUtil.with().setBitmapSize(1000)
//                    .setItemMargin(20).setPaddingSize(20).build();
//            imgList.add(urlArray[1]);
//            imgList.add(urlArray[2]);

//            nineCellBitmapUtil.collectBitmap(imgList, new NineCellBitmapUtil.BitmapCallBack() {
//                @Override
//                public void onLoadingFinish(Bitmap bitmap) {
//                }
//            });

//????????????
            TIMGroupManager.getInstance().createGroup(param, new TIMValueCallBack<String>() {
                @Override
                public void onError(int code, String desc) {
                    Log.d(TAG, "create group failed. code: " + code + " errmsg: " + desc);
                    result.error(desc, String.valueOf(code), null);
                }

                @Override
                public void onSuccess(String s) {
                    Log.d(TAG, "create group succ, groupId:" + s);
                    result.success("create group succ, groupId:" + s);
                }
            });

        } else if (call.method.equals("editFriendNotes")) {
            String identifier = call.argument("identifier");
            String remarks = call.argument("remarks");
            HashMap<String, Object> hashMap = new HashMap<>();
// ??????????????????
            hashMap.put(TIMFriend.TIM_FRIEND_PROFILE_TYPE_KEY_REMARK, remarks);
            TIMFriendshipManager.getInstance().modifyFriend(identifier, hashMap, new TIMCallBack() {
                @Override
                public void onError(int i, String s) {
                    Log.e(TAG, "editFriendNotes err code = " + i + ", desc = " + s);
                    result.error(s, String.valueOf(i), null);
                }

                @Override
                public void onSuccess() {
                    Log.i(TAG, "editFriendNotes success");
                    result.success("editFriendNotes success");
                }
            });
        } else if (call.method.equals("getRemark")) {
            try {
                String identifier = call.argument("identifier");
// ??????????????????
                TIMFriend friend = TIMFriendshipManager.getInstance().queryFriend(identifier);
                if (friend != null) {
                    result.success(friend.getRemark());
                } else {
                    result.error("???????????????", "??????", null);
                }
            } catch (NullPointerException e) {
                System.out.println("????????????!" + e);
            }
        } else if (call.method.equals("getGroupMembersList")) {
            String groupId = call.argument("groupId");

//            final List<String> userS = new ArrayList<>();
            final List<String> mData = new ArrayList<>();

            //????????????
            TIMValueCallBack<List<TIMGroupMemberInfo>> cb = new TIMValueCallBack<List<TIMGroupMemberInfo>>() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "getGroupMembersList onErr. code: " + code + " errmsg: " + desc);
                    result.error(desc, "getGroupMembersList on Err code: " + code, null);
                }

                @Override
                public void onSuccess(List<TIMGroupMemberInfo> infoList) {//??????????????????????????????

                    for (TIMGroupMemberInfo infoIM : infoList) {
//                        userS.add(infoIM.getUser());
                        mData.add("{'user':'" + infoIM.getUser() + "'");
                        mData.add("'joinTime':'" + infoIM.getJoinTime() + "'," +
                                "'nameCard':'" + infoIM.getNameCard() + "'," +
                                "'msgFlag':'" + infoIM.getMsgFlag() + "'," +
                                "'msgSeq':'" + infoIM.getMsgSeq() + "'," +
                                "'silenceSeconds':'" + infoIM.getSilenceSeconds() + "'," +
                                "'tinyId':'" + infoIM.getTinyId() + "'," +
                                "'role':'" + infoIM.getRole() + "'}");
                    }
                    result.success(mData.toString());
                }
            };

//            TIMFriendshipManager.getInstance().getUsersProfile(userS, true, new TIMValueCallBack<List<TIMUserProfile>>() {
//                @Override
//                public void onError(int code, String desc) {
//                    //????????? code ??????????????? desc????????????????????????????????????
//                    //????????? code ???????????????????????????
//                    Log.e(TAG, "getUsersProfile failed: " + code + " desc");
//                }
//
//                @Override
//                public void onSuccess(List<TIMUserProfile> timUserProfiles) {
//                    if (timUserProfiles != null && timUserProfiles.size() > 0) {
//                        TIMUserProfile info = timUserProfiles.get(0);
//                        mData.add("'nickName':'" + info.getNickName() + "'");
//                        mData.add("'allowType':'" + info.getAllowType() + "'");
//                        mData.add("'faceUrl':'" + info.getFaceUrl() + "'");
//                        mData.add("'identifier':'" + info.getIdentifier() + "'");
//                    } else {
//                        mData.add("'info':" + "[]");
//                    }
//
//                }
//            });

//????????????????????????
            TIMGroupManager.getInstance().getGroupMembers(
                    groupId, cb);     //??????

        } else if (call.method.equals("inviteGroupMember")) {
            //????????????????????????????????????
            ArrayList list = call.argument("list");
            String groupId = call.argument("groupId");

            TIMGroupManager.getInstance().inviteGroupMember(groupId, list, new TIMValueCallBack<List<TIMGroupMemberResult>>() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "addGroupMembers failed, code: " + code + "|desc: " + desc);
                    result.error(desc, "code:" + code, null);
                }

                @Override
                public void onSuccess(List<TIMGroupMemberResult> timGroupMemberResults) {
                    Log.e(TAG, "??????????????????");
                    final List<String> adds = new ArrayList<>();

                    if (timGroupMemberResults.size() > 0) {
                        for (int i = 0; i < timGroupMemberResults.size(); i++) {
                            TIMGroupMemberResult res = timGroupMemberResults.get(i);
                            if (res.getResult() == 3) {
//                                result.success("?????????????????????????????????");
                                return;
                            }
                            if (res.getResult() > 0) {
                                adds.add(res.getUser());
                            }
                        }
                        Log.e(TAG, "?????????????????????????????????");
                        result.success("????????????");
                    }
                    if (adds.size() > 0) {
                        Log.e(TAG, "adds.size() > 0");
                    }
                }
            });
        } else if (call.method.equals("quitGroup")) {

            String groupId = call.argument("groupId");

            TIMGroupManager.getInstance().quitGroup(groupId, new TIMCallBack() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "quitGroup failed, code: " + code + "|desc: " + desc);
                    result.error(desc, "quitGroup failed, code: " + code, null);
                }

                @Override
                public void onSuccess() {
                    Log.e(TAG, "quit group succ");
                    result.success("quit group succ");
                }
            });
        } else if (call.method.equals("deleteGroupMember")) {
            String groupId = call.argument("groupId");
            ArrayList deleteList = call.argument("deleteList");

            TIMGroupManager.DeleteMemberParam param = new TIMGroupManager.DeleteMemberParam(groupId, deleteList);
            param.setReason("some reason");

            TIMGroupManager.getInstance().deleteGroupMember(param, new TIMValueCallBack<List<TIMGroupMemberResult>>() {
                @Override
                public void onError(int code, String desc) {
                    Log.e(TAG, "deleteGroupMember onErr. code: " + code + " errmsg: " + desc);
                    result.error(desc, "deleteGroup on Err code: " + code, null);
                }

                @Override
                public void onSuccess(List<TIMGroupMemberResult> results) { //????????????????????????
                    List<String> mData = new ArrayList<>();

                    for (TIMGroupMemberResult r : results) {
                        Log.d(TAG, "result: " + r.getResult()  //????????????:  0??????????????????1??????????????????2?????????????????????
                                + " user: " + r.getUser());    //????????????
                        mData.add("result:" + r.getResult()
                                + "user:" + r.getUser());
                    }
                    result.success(mData.toString());

                }
            });
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        Log.e(TAG, "onCancel() called with: o = [" + o + "]");
    }


    class Message {
        TIMUserProfile senderProfile;
        TIMConversation timConversation;
        TIMGroupMemberInfo timGroupMemberInfo;
        long timeStamp;
        TIMElem message;

        Message(TIMMessage timMessage) {
            timMessage.getSenderProfile(new TIMValueCallBack<TIMUserProfile>() {
                @Override
                public void onError(int i, String s) {

                }

                @Override
                public void onSuccess(TIMUserProfile timUserProfile) {
                    senderProfile = timUserProfile;
                }
            });
            timConversation = timMessage.getConversation();
            message = timMessage.getElement(0);
            timeStamp = timMessage.timestamp();
            timGroupMemberInfo = timMessage.getSenderGroupMemberProfile();
        }
    }
}
