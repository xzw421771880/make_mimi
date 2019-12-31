


import 'package:dio/dio.dart';
import 'package:make_mimi/api/river_api.dart';
import 'package:make_mimi/utils/http_util.dart';
import 'package:make_mimi/utils/showtoast_util.dart';

typedef OnSuccess<T>(T data);

typedef OnFail(String message);

class Com_Service {


  Future get(Map<String, dynamic> parameters,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      var response =
      await HttpUtil.instance.get(Api.BASE_URL+url,parameters: parameters);
      print(response);
      if (response['code'] == 200) {
        success(response["data"]);
      } else if(response['code'] == 4032||response['code'] == 4032){

        showToast("账号失效");
      }else{
        showToast(response['message']);
        onFail(response['message']);
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
      if (response['code'] == 200) {
        success(response["data"]);
      } else if(response['code'] == 4032||response['code'] == 4032){

        showToast("账号失效");
      }else{
        showToast(response['message']);
        onFail(response['message']);
      }
    } catch (e) {
      print(e);
//      onFail(Strings.SERVER_EXCEPTION);

    }
  }



  Future POSTIMAGE(FormData data,String url, OnSuccess success,
      OnFail onFail) async {
    try {
      var response =
      await HttpUtil.instance.postImage(Api.BASE_URL+url,data: data);
      if (response['code'] == 200) {
        success(response["data"]);
      } else {
        showToast(response['message']);
      }
    } catch (e) {
      print(e);

    }
  }

}