import 'dart:io';

import 'package:task_app/task_app.dart' as task_app;
import 'package:neat_periodic_task/neat_periodic_task.dart';

import '../apis/duyuru_api.dart';
import '../apis/haber_api.dart';
import '../helpers/file_helper.dart';

void main(List<String> arguments) async {
  // Create a periodic task that prints 'Hello World' every 30s
  final scheduler = NeatPeriodicTaskScheduler(
    interval: Duration(minutes: 30),
    name: 'borusan_func',
    timeout: Duration(seconds: 5),
    task: () async {
      String? fileHaber = await FileHelper.haberOku();
      String? fileDuyuru = await FileHelper.duyuruOku();
      var haberRes = await HaberApi().haberCek();
      var duyuruRes = await DuyuruApi().duyuruCek();

      if (fileHaber != null && fileHaber != haberRes.url) {
        FileHelper.haberYazdir(haberRes.url);
        haberRes.yazdir();

        //NOTIFICATION GONDER
      } else {
        print('Haber ayni');
      }
      if (fileDuyuru != null && fileDuyuru != duyuruRes.url) {
        FileHelper.duyuruYazdir(duyuruRes.url);
        duyuruRes.yazdir();

        //NOTIFICATION GONDER
      } else {
        print('Duyuru ayni');
      }

      // FileHelper.haberYazdir(haberRes.url);
      // FileHelper.duyuruYazdir(duyuruRes.url);

      // for (var element in duyuruRes) {
      //   print('DUYURU ${element.title}');
      // }
      print('###############################');
    },
    minCycle: Duration(seconds: 5),
  );

  scheduler.start();
  await ProcessSignal.sigterm.watch().first;
  await scheduler.stop();
}
