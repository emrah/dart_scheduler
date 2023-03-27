import 'dart:io';

class FileHelper {
  static Future<bool> haberYazdir(String l) async {
    try {
      //final directory = await getApplicationDocumentsDirectory();

      var f = File('haber.txt');
      f.writeAsString(l);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> duyuruYazdir(String l) async {
    try {
      // final directory = await getApplicationDocumentsDirectory();

      var f = File('duyuru.txt');
      f.writeAsString(l);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> haberOku() async {
    try {
      // final directory = await getApplicationDocumentsDirectory();

      var f = File('haber.txt');
      String l = await f.readAsString();
      return l;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> duyuruOku() async {
    try {
      // final directory = await getApplicationDocumentsDirectory();

      var f = File('duyuru.txt');
      String l = await f.readAsString();
      return l;
    } catch (e) {
      return null;
    }
  }
}
