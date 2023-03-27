import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import '../models/haber_model.dart';

class HaberApi {
  Future<HaberModel> haberCek() async {
    // List<HaberModel> haberler = [];

    return await getir(
        'https://borusan.meb.k12.tr/tema/icerikler/listele_87751_haber');

    // for (var i = 2; i <= 5; i++) {
    //   haberler.addAll(await getir(
    //       'https://borusan.meb.k12.tr/tema/icerik.php?KATEGORINO=87751&git=$i'));
    // }

    // return haberler;
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
        .querySelectorAll('a.thumb_image_list ')
        .map(
          (e) => 'https://borusan.meb.k12.tr/${e.attributes['href']}',
        )
        .first;

    // urlX.addAll(urls);

    final urlImages = html
        .querySelectorAll('img.img-thumbnail')
        .map(
          (e) => 'https://borusan.meb.k12.tr/${e.attributes['src']}',
        )
        .first;
    final dates = html
        .querySelectorAll('p.yil > time')
        .map(
          (e) => '${e.attributes['datetime']}',
          // (e) => e.innerHtml.trim().substring(0, 25),
        )
        .first;
    return HaberModel(
      title: titles,
      url: urls,
      // urlImage: 'BOS',
      // date: 'bos',

      urlImage: urlImages,
      date: dates,
    );
  }
}
// #liste > div:nth-child(2) > div:nth-child(1) > div.tarih > p.yil > time