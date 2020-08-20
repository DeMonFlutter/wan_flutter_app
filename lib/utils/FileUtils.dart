import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// @author DeMon
/// Created on 2020/6/12.
/// E-mail 757454343@qq.com
/// Desc:
class FileUtils {
  static Future<String> getCacheFile() async {
    // 获取应用目录
    String dir = (await getTemporaryDirectory()).path;
    return dir;
  }

  static Future<String> getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    return dir;
  }

  static Future<String> getFilePath(String filePath) async {
    File file = await getFile(filePath);
    return file.path;
  }

  static Future<File> getFile(String filePath) async {
    String localFile = await getLocalFile();
    File file = new File(localFile + "/" + filePath);
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  static writeFile(String filePath, String content) async {
    File file = await getFile(filePath);
    file.writeAsStringSync(content);
  }

  static Future<String> readFile(String filePath) async {
    File file = await getFile(filePath);
    return await file.readAsString();
  }
}
