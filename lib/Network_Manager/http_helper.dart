import 'dart:convert';
import 'dart:io';
import 'package:food_donation/utils/printvalu.dart';
import 'package:food_donation/utils/tostmassage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class HttpHelper {
  // get api
  Future<dynamic> get(
      {required String url, bool isRequireAuthorization = false}) async {
    Map<String, String> apiHeader = {'content-type': 'application/json'};

    if (isRequireAuthorization) {
      apiHeader = {
        'content-type': 'application/json',
        'Authoriztion': 'berear "userberer token"',
      };
    }
    try {
      final apiRespons = await http.get(Uri.parse(url), headers: apiHeader);
      printvalue(
        url,
        tag: 'Api get Url',
      );
      printvalue(
        apiHeader,
        tag: 'Api header: ',
      );
      printvalue(apiRespons.body, tag: 'Api Response');

      return _returnResponse(response: apiRespons);
    } on SocketDirection {
      return null;
    }
  }

// post
  Future<dynamic> post(
      {required String url,
      Object? requestBody,
      bool isRequireAuthorization = false}) async {
    Map<String, String> apiHeader = {'content-type': 'application/json'};

    if (isRequireAuthorization) {
      apiHeader = {
        'content-type': 'application/json',
        'Authoriztion': 'berear "userberer token"',
      };
    }
    try {
      http.Response apiRespons;
      if (requestBody == null) {
        apiRespons = await http.post(Uri.parse(url), headers: apiHeader);
      } else {
        apiRespons = await http.post(Uri.parse(url),
            body: jsonEncode(requestBody), headers: apiHeader);
      }
      printvalue(
        url,
        tag: 'Api Post Url : ',
      );
      printvalue(
        requestBody,
        tag: 'Api Req Body :',
      );
      printvalue(
        apiHeader,
        tag: 'api Header: ',
      );
      printvalue(
        apiRespons.body,
        tag: 'Api Response',
      );
      return _returnResponse(response: apiRespons);
    } on SocketException {
      return null;
    }
  }

// put
  Future<dynamic> put(
      {required String url,
      Object? requestBody,
      bool isRequireAuthorization = false}) async {
    Map<String, String> apiHeader = {};

    if (isRequireAuthorization) {
      apiHeader = {
        'Authoriztion': 'berear "userberer token"',
      };
    }
    try {
      http.Response apiRespons;
      if (requestBody == null) {
        apiRespons = await http.put(Uri.parse(url), headers: apiHeader);
      } else {
        apiRespons = await http.put(Uri.parse(url), body: requestBody);
      }
      printvalue(
        url,
        tag: 'Api Post Url : ',
      );
      printvalue(
        requestBody,
        tag: 'Api Req Body :',
      );
      printvalue(
        apiHeader,
        tag: 'api Header: ',
      );
      printvalue(
        apiRespons.body,
        tag: 'Api Response',
      );
      return _returnResponse(response: apiRespons);
    } on SocketException {
      return null;
    }
  }

// delete
  Future<dynamic> delete(
      {required String url,
      Object? requestBody,
      bool isRequireAuthorization = false}) async {
    Map<String, String> apiHeader = {'content-type': 'application/json'};

    if (isRequireAuthorization) {
      apiHeader = {
        'content-type': 'application/json',
        'Authoriztion': 'berear "userberer token"',
      };
    }
    try {
      http.Response apiRespons;
      if (requestBody == null) {
        apiRespons = await http.delete(Uri.parse(url), headers: apiHeader);
      } else {
        apiRespons = await http.delete(Uri.parse(url),
            headers: apiHeader, body: requestBody);
      }
      printvalue(
        url,
        tag: 'Api Post Url : ',
      );
      printvalue(
        requestBody,
        tag: 'Api Req Body :',
      );
      printvalue(
        apiHeader,
        tag: 'api Header: ',
      );
      printvalue(
        apiRespons.body,
        tag: 'Api Response',
      );
      return _returnResponse(response: apiRespons);
    } on SocketException {
      return null;
    }
  }

// multipart api

  Future<dynamic> uploadimages(
      {required File imagefile, required String url}) async {
    try {
      var request = http.MultipartRequest('post', Uri.parse(url));
      request.headers.addAll({'content-type ': 'mulitpart/from-data'});

      request.files.add(await http.MultipartFile.fromPath(
          'file', imagefile.path,
          filename: imagefile.toString().split('').last));

      StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);

      printvalue(
        url,
        tag: 'Api Multipart Url : ',
      );
      printvalue(
        {'contant type ': 'multipart/from- data'},
        tag: 'Api header : ',
      );
      printvalue(
        response.body,
        tag: 'api Response',
      );
      return _returnResponse(response: response);
    } on SocketException {
      return null;
    }
  }
}

dynamic _returnResponse({required http.Response response}) {
  switch (response.statusCode) {
    case 200:
      var responsejson = json.decode(response.body);
      return responsejson;

    case 201:
      var responsejson = json.decode(response.body);
      return responsejson;

    case 400:
      var decodeError = json.decode(response.body);
      // toastMessage(decodeError.toString());

      if (decodeError.containskey('error')) {
        // show message to  user
        toastMessage(decodeError['error'].toString()); // show message to  user
      }

      throw Exception(' api error status Code 400');
    case 401:
      throw Exception('unauthorized 401'); // wrong tokken

    case 500:
      throw Exception(
          'Error occurred while communication with server with statusCode 500');

    default:
      throw Exception(
          'Error occurred while communication with server with statusCode ${response.statusCode.toString()} ');
  }
}
