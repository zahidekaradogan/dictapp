//burada veritabanı üzerinden veri çekmek için metodları oluşturcaz.
//biri tüm kelimeleri alacak.
//diğeri arama yapacak. arama ile sonuçları almış olucaz.

import 'package:dictapp/database_helper.dart';
import 'package:dictapp/words.dart';

class Wordsdao{

  Future<List<Words>> allWords () async {

    var db = await DatabaseHelper.databaseAccess();

   List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM words");

   return List.generate(maps.length, (i) {
     var line = maps[i];
     return Words(line["word_id"], line["english"], line["turkhis"]);

   });
  }

  Future<List<Words>> searchWord (String searchedWord) async {

    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM words WHERE english like '%searchedWord%'");

    return List.generate(maps.length, (i) {
      var line = maps[i];
      return Words(line["word_id"], line["english"], line["turkhis"]);

    });
  }
}