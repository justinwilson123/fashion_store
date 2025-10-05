import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fashion/core/constant/app_links.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile {
  Dio dio = Dio();
  Future<bool> existFile(String fileName) async {
    final direc = await getApplicationCacheDirectory();
    final path = "${direc.path}/$fileName";
    final file = File(path);
    return await file.exists();
  }

  Future<bool> downloadImage(String fileName) async {
    if (await existFile(fileName)) {
      return true;
    } else {
      final dir = await getApplicationCacheDirectory();
      final List<String> parts = fileName.split("/");
      final namefolder = parts[0];
      final nameImage = parts[1];
      final dirFolder = Directory("${dir.path}/$namefolder");
      await dirFolder.create(recursive: true);
      try {
        final response = await dio.download(
          "${AppLinks.chatImages}$nameImage",
          '${(await getApplicationCacheDirectory()).path}/$fileName',
        );
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        // print(e);
        return false;
      }
    }
  }

  Future<bool> downloadVoice(String fileName) async {
    if (await existFile(fileName)) {
      return true;
    } else {
      try {
        final response = await dio.download(
          "${AppLinks.chatVoices}$fileName",
          '${(await getApplicationCacheDirectory()).path}/$fileName',
        );
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        // print(e);
        return false;
      }
    }
  }
}
