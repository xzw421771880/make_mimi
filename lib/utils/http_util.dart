

import 'package:dio/dio.dart';
import 'package:make_mimi/api/river_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio;

class HttpUtil {
  // 工厂模式
  static HttpUtil get instance => _getInstance();

  static HttpUtil _httpUtil;

  static HttpUtil _getInstance() {
    if (_httpUtil == null) {
      _httpUtil = HttpUtil();
    }
    return _httpUtil;
  }

  HttpUtil() {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    dio = new Dio(options);
//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//      // config the http client
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY localhost:8888";
//        return "118.31.124.185:8888";
//      };
//      // you can also create a new HttpClient to dio
//      // return new HttpClient();
//    };

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("========================请求数据===================1");
      print("url=${options.uri.toString()}");
      print('token ====');
      print("params=${options.data}");
      dio.lock();


      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String token = sharedPreferences.getString('token') ?? null;

      print('token ====  ${token}');

      String url = options.uri.toString().replaceAll(Api.BASE_URL+'/', "");
      print(url);
      List list = url.split('/');
      print(list);
      print('${list[0]}-----pppppppp');
      if (list[0] == 'p'){
        options.headers['Authorization'] = token;
      }
//     await SharedPreferencesUtils.getToken().then((token) {
//        options.headers['token'] = token;
//      });
      dio.unlock();
      return options;
    }, onResponse: (Response response) {
      print("========================请求数据===================2");
      print("code=${response.statusCode}");
      print("response=${response.data}");
    }, onError: (DioError error) {
      print("========================请求错误===================3");
      print("message---");
      print("message =${error.message}");
      print("message---");
      print("message =${error.response}=+=");
    }));
  }

  Future get(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response =
          await dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.get(url, options: options);
    } else {
      response = await dio.get(url);
    }
    return response;
  }

  Future post(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    print("message =${response}=+=-");
    return response;
  }

  Future postStr(String url,
      {String parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    print("message =${response}=+=-");
    return response;
  }

  Future postAry(String url,
      {List parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    return response;
  }

  Future deleteAry(String url,
      {List parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.delete(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.delete(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.delete(url, options: options);
    } else {
      response = await dio.delete(url);
    }
    return response;
  }

  Future postImage(String url,
      {FormData data, Options options}) async {
    Response response;
    if (data != null && options != null) {
      response = await dio.post(url, data: data, options: options);
    } else if (data != null && options == null) {
      response = await dio.post(url, data: data);
    } else if (data == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    return response;
  }
}
