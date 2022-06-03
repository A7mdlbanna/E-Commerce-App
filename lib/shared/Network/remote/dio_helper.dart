import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//
class DioHelper {
  static Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response?> getData({
    required String url,
    query,
    lang = 'en',
    token,
  })async{
    dio?.options.headers = {
      'lang' : lang,
      'authorization' : token??'',
      'Content-Type': 'application/json',
    };
    return dio?.get(
        url,
        queryParameters: query
    );
  }
  static Future<Response?> postData({
    required String url,
    required data,
    lang = 'en',
    token
  })async {
    dio?.options.headers = {
      'lang' : lang,
      'authorization' : token??'',
      'Content-Type': 'application/json',
    };
    return dio?.post(
      url,
      data: data,
    );
  }
}