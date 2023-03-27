// import 'package:path_provider/path_provider.dart';

class HaberModel {
  late String url;
  late String title;
  late String urlImage;
  late String date;

  HaberModel({
    required this.url,
    required this.title,
    required this.urlImage,
    required this.date,
  });

  yazdir() async {
    print('$url $title $urlImage $date');
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
  }

  HaberModel.fromJson(Map<dynamic, String> map) {
    url = map['url']!;
    title = map['title']!;
    urlImage = map['urlImage']!;
    date = map['date']!;
  }
}
