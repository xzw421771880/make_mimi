


import 'package:dio/dio.dart';
import 'package:make_mimi/api/river_api.dart';
import 'package:make_mimi/utils/http_util.dart';

typedef OnSuccess<T>(T data);

typedef OnFail(String message);

class Com_Service {


  Future get(Map<String, dynamic> parameters,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      Response response =
      await HttpUtil.instance.get(Api.BASE_URL+url,parameters: parameters);
      print(response);
      if (response.statusCode == 200) {
        success(response.data);
      }else if(response.statusCode == 400){


//      print("退出----------")；
//        showToast("账号失效");
//        outEvent.fire("退出");

      } else {
//        showToast(response['message']);
      }
    } catch (e) {
      print('---');
      print(e);
//      onFail(Strings.SERVER_EXCEPTION);
    }
  }

  Future post(Map<String, dynamic> parameters,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      var response =
      await HttpUtil.instance.post(Api.BASE_URL+url,parameters: parameters);
      print('成功');
      if (response.statusCode == 200) {
        success(response.data);
      } else if(response.statusCode == 400){
        print('400---${response.data}');
//        outEvent.fire("退出");
//
//        showToast("账号失效");
      }else{
//        showToast(response['message']);
//        onFail(response.);
      }
    } catch (e) {
      print('失败');
      print(e);
//      print('400---${response.data}');
//      onFail(Strings.SERVER_EXCEPTION);

    }
  }

  Future postStr(String parameters,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      Response response =
      await HttpUtil.instance.postStr(Api.BASE_URL+url,parameters: parameters);
      if (response.statusCode == 200) {
        success(response.data);
      } else if(response.statusCode == 400){
        print('400---${response.data}');
//        outEvent.fire("退出");
//
//        showToast("账号失效");
      }else{
//        showToast(response['message']);
//        onFail(response.);
      }
    } catch (e) {
      print(e);
      print('-----400');
//      print('400---${response.data}');
//      onFail(Strings.SERVER_EXCEPTION);

    }
  }

  Future postAry(List parameters,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      Response response =
      await HttpUtil.instance.postAry(Api.BASE_URL+url,parameters: parameters);
      if (response.statusCode == 200) {
        success(response.data);
      } else if(response.statusCode == 4032){
//        outEvent.fire("退出");
//
//        showToast("账号失效");
      }else{
//        showToast(response['message']);
//        onFail(response.);
      }
    } catch (e) {
      print(e);
//      onFail(Strings.SERVER_EXCEPTION);

    }
  }

  Future deleteAry(List parameters,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      Response response =
      await HttpUtil.instance.deleteAry(Api.BASE_URL+url,parameters: parameters);
      if (response.statusCode == 200) {
        success(response.data);
      } else if(response.statusCode == 4032){
//        outEvent.fire("退出");
//
//        showToast("账号失效");
      }else{
//        showToast(response['message']);
//        onFail(response.);
      }
    } catch (e) {
      print(e);
//      onFail(Strings.SERVER_EXCEPTION);

    }
  }



  Future POSTIMAGE(FormData data,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      Response response =
      await HttpUtil.instance.postImage(Api.BASE_URL+url,data: data);
      if (response.statusCode == 200) {
        success(response.data);
      } else {
//        showToast(response['message']);
      }
    } catch (e) {
      print(e);
//      onFail(Strings.SERVER_EXCEPTION);

    }
  }

}