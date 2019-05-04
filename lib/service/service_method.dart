import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(String url, [dynamic params]) async {
  try{
    Response res;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if(params == null){
      res = await dio.post(servicePath[url]);
    }else{
      res = await dio.post(servicePath[url],data:params);
    }
    if(res.statusCode == 200){
      return res.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况');
    }
  }catch(e){
    return print('Error:=======>$e');
  }
}