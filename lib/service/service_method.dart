import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future getHomePageContent() async {
  try{
    print('开始获取首页数据...');
    Response res;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon':'115.02932','lat':'35.76189'};
    res = await dio.post(servicePath['homePageContext'],data:formData);
    if(res.statusCode == 200){
      return res.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况');
    }
  }catch(e){
    return print('Error:=======>$e');
  }
}