import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//
class DioHelper {
  static Dio? dio;
  static Dio? picsDio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
    picsDio = Dio(
      BaseOptions(
        baseUrl: 'https://api.remove.bg/v1.0/',
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
    data,
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
  static Future<Response?> uploadData({
    required String url,
    data,
    lang = 'en',
    token
  })async {
    dio?.options.headers = {
      'lang' : lang,
      'authorization' : token??'',
      'Content-Type': 'application/json',
    };
    return dio?.put(
      url,
      data: data,
    );
  }
  static Future<Response?> postPNGPic({
    required String url,
    data,
  })async {
    picsDio?.options.headers = {
      'Content-Type': 'application/json',
      'X-Api-Key' : 'JFxF6htjSJCHpgLZXGwFZR6N',
    };
    return picsDio?.post(
      url,
      data: data,
    );
  }
}