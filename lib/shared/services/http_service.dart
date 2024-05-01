import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:prueba_app/shared/helpers/global_helpers.dart';
import 'package:prueba_app/shared/models/general_response.dart';
import 'package:prueba_app/shared/providers/functional_provider.dart';
import 'package:prueba_app/shared/widget/alert/alerts_template.dart';


class InterceptorHttp {
  Future<GeneralResponse> request(
    BuildContext context,
    String method,
    String urlEndPoint,
    dynamic body, {
    bool showLoading = true,
    Map<String, dynamic>? queryParameters,
    List<http.MultipartFile>? multipartFiles,
    Map<String, String>? multipartFields,
    String requestType = "JSON",
    Function(int sentBytes, int totalBytes)? onProgressLoad,
  }) async {


    String url = "$urlEndPoint?${Uri(queryParameters: queryParameters).query}";

    GlobalHelper.logger.t('URL $method: $url');

    body != null ? GlobalHelper.logger.log(Level.trace, 'body: ${json.encode(body)}') : null;
    queryParameters != null ? GlobalHelper.logger.log(Level.trace, 'queryParameters: ${json.encode(queryParameters)}') : null;

    GeneralResponse generalResponse = GeneralResponse(data: null, message: "", error: true);

    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final keyLoading = GlobalHelper.genKey();
    final keyError = GlobalHelper.genKey();

    String? messageButton;
    void Function()? onPress;

    try {
      http.Response _response;
      Uri uri = Uri.parse(url);

      if (showLoading) {
        fp.showAlertLoading(key: keyLoading, content: const AlertLoading());
        await Future.delayed(const Duration(milliseconds: 600));
      }

      //? Envio de TOKEN
      //LoginResponse? userData = await UserDataStorage().getUserData();

      String tokenSesion = "";

      // if (userData != null) {
      //   tokenSesion = userData.tokenSession;
      // }

      Map<String, String> _headers = {
        "Content-Type": "application/json",
        "token": (requestType == 'JSON') ? tokenSesion : tokenSesion,
      };

      int responseStatusCode = 0;
      String responseBody = "";

      switch (requestType) {
        case "JSON":
          switch (method) {
            case "POST":
              _response = await http.post(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "GET":
              _response = await http.get(uri, headers: _headers);
              break;
            case "PUT":
              _response = await http.put(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "PATCH":
              _response = await http.patch(uri,
                  headers: _headers,
                  body: body != null ? json.encode(body) : null);
              break;

            default:
              _response = await http.post(uri, body: jsonEncode(body));
              break;
          }
          responseStatusCode = _response.statusCode;
          responseBody = _response.body;

          GlobalHelper.logger.log(Level.trace, json.decode(responseBody));

          break;
        case "FORM":
          final httpClient = getHttpClient();
          final request = await httpClient.postUrl(Uri.parse(url));

          int byteCount = 0;
          var requestMultipart = http.MultipartRequest(method, Uri.parse(url));
       
          if (multipartFiles != null) {
            requestMultipart.files.addAll(multipartFiles);
          }
          if (multipartFields != null) {
            requestMultipart.fields.addAll(multipartFields);
          }

          _headers.forEach((key, value) {
            request.headers.set("token", tokenSesion);
          });

          var msStream = requestMultipart.finalize();

          var totalByteLength = requestMultipart.contentLength;

          request.contentLength = totalByteLength;

          request.headers.set(HttpHeaders.contentTypeHeader,
              requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

          Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onProgressLoad != null) {
                  onProgressLoad(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                generalResponse.error = true;
                throw error;
              },
              handleDone: (sink) {
                sink.close();
              },
            ),
          );

          await request.addStream(streamUpload);

          final httpResponse = await request.close();
          var statusCode = httpResponse.statusCode;

          responseStatusCode = statusCode;
          if (statusCode ~/ 100 != 2) {
            throw Exception('Error uploading file, Status code: ${httpResponse.statusCode}');
          } else {
            await for (var data in httpResponse.transform(utf8.decoder)) {
              responseBody = data;
            }
          }
          GlobalHelper.logger.log(Level.trace, json.decode(responseBody));
          break;
      }
      
 
      switch (responseStatusCode) {
        case 200:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          generalResponse.error = false;        
          break;
        case 307:
          generalResponse.error = true;
          generalResponse.message = "Ocurrió un error al consultar con los servicios. Intente con una red que le permita el acceso";
          fp.dismissAlertLoading(key: keyLoading);
          break;
        case 401:
          var responseDecoded = json.decode(responseBody);
          generalResponse.message = responseDecoded["message"];
          generalResponse.error = true;
          fp.dismissAlertLoading(key: keyLoading);
          break;
        default:
          generalResponse.error = true;
          generalResponse.message = json.decode(responseBody)["message"];
          fp.dismissAlertLoading(key: keyLoading);
          break;
      }
    } on TimeoutException catch (e) {
      GlobalHelper.logger.e("ERROR ON TimeoutException->: $e");
      generalResponse.error = true;
      generalResponse.message = 'Tiempo de conexión excedido.';
      fp.dismissAlertLoading(key: keyLoading);
    } on FormatException catch (ex) {
      generalResponse.error = true;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
      GlobalHelper.logger.e(ex);
      fp.dismissAlertLoading(key: keyLoading);
    } on SocketException catch (exSock) {
      GlobalHelper.logger.e("Error por conexion: $exSock");
      generalResponse.error = true;
      generalResponse.message = "Verifique su conexión a internet y vuelva a intentar.";
      fp.dismissAlertLoading(key: keyLoading);
    } on Exception catch (e, stacktrace) {
      GlobalHelper.logger.e("Error en request: $stacktrace");
      generalResponse.error = true;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
      fp.dismissAlertLoading(key: keyLoading);
    }

    if (!generalResponse.error) {
      if (showLoading) {
         fp.dismissAlertLoading(key: keyLoading);
      }
    } else {
      fp.showAlert(
        key: keyError,
        content: AlertGeneric(
          content: ErrorGeneric(
            keyToClose: keyError,
            message: generalResponse.message,
            messageButton: messageButton,
            onPress: onPress,
          ),
        ),
      );
    }
    return generalResponse;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}