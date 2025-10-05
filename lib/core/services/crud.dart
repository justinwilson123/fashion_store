import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../error/exception.dart';

class Crud {
  final http.Client client;
  Crud(this.client);

  Future<Map> postData(String url, Map data) async {
    var response = await client.post(Uri.parse(url), body: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  Future<Map> postDataWithFile(
    url,
    data,
    File? image, [
    String? namerequest,
  ]) async {
    namerequest ??= "files";
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(
        namerequest,
        stream,
        length,
        filename: basename(image.path),
      );
      request.files.add(multipartFile);
    }
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  Future<Stream<double>> uploadFileWithStreamUpload(
    String url,
    String? filePath,
  ) async {
    if (filePath != null) {
      final file = File(filePath);

      final fileLength = await file.length();

      var request = http.MultipartRequest('POST', Uri.parse(url));

      var stream = http.ByteStream(file.openRead());
      var multipartFile = http.MultipartFile(
        'files',
        stream,
        fileLength,
        filename: basename(file.path),
      );

      request.files.add(multipartFile);

      var myRequest = await request.send();

      var controller = StreamController<double>();
      var totalByteLength = 0;

      myRequest.stream.listen(
        (List<int> chunk) {
          totalByteLength += chunk.length;
          final progress = totalByteLength / fileLength;
          // print(progress);
          controller.add(progress);
        },
        onDone: () {
          controller.add(1.0);

          controller.close();
        },
        onError: (error) {
          controller.addError(error);
        },
      );
      return controller.stream;
    } else {
      throw NoDataException();
    }
  }

  // Stream<double> uploadfileWithDio (){
  //   var details = Dio().downloadUri(uri, savePath)
  // }
}
