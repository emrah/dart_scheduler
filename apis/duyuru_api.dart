import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import '../models/haber_model.dart';

class DuyuruApi {
  Future<HaberModel> duyuruCek() async {
    return await getir(
        'https://borusan.meb.k12.tr/tema/icerikler/listele_87752_duyuru');
  }

  Future<HaberModel> getir(String s) async {
    final url = Uri.parse(s);
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('div.liste_baslik > a ')
        .map((e) => e.innerHtml.trim())
        .first;

    final urls = html
        .querySelectorAll('div.liste_baslik > a')
        .map(
          (e) => 'https://borusan.meb.k12.tr/${e.attributes['href']}',
        )
        .first;
// #liste > div:nth-child(2) > div.row > div.col-sm-4 > a > img
    final urlImages = html
        .querySelectorAll('div.col-sm-4 > a > img')
        .map(
          (e) => 'https://borusan.meb.k12.tr/${e.attributes['src']}',
        )
        .first;
    final dates = html
        .querySelectorAll('p.yil > time')
        .map(
          (e) => '${e.attributes['datetime']}',
        )
        .first;
    return HaberModel(
      title: titles,
      url: urls,
      urlImage: urlImages,
      date: dates,
    );
  }
}
