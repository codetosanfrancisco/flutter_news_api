import 'dart:convert' as c;

class ItemModel {
  int id;
  bool deleted;
  String type;
  String by;
  int time;
  String text;
  bool dead;
  int parent;
  List<dynamic> kids;
  String url;
  int score;
  String title;
  int descendants;

  ItemModel.fromDb(Map<String, dynamic> parsedJSon) {
    id = parsedJSon['id'];
    deleted = parsedJSon['deleted'] == 1;
    type = parsedJSon['type'];
    by = parsedJSon['by'];
    time = parsedJSon['time'];
    text = parsedJSon['text'];
    dead = parsedJSon['dead'] == 1;
    parent = parsedJSon['parent'];
    kids = c.jsonDecode(parsedJSon['kids']);
    url = parsedJSon['url'];
    score = parsedJSon['score'];
    title = parsedJSon['title'];
    descendants = parsedJSon['descendants'];
  }

  ItemModel.fromJson(Map<String, dynamic> parsedJSon) {
    id = parsedJSon['id'];
    deleted = parsedJSon['deleted'];
    type = parsedJSon['type'];
    by = parsedJSon['by'];
    time = parsedJSon['time'];
    text = parsedJSon['text'];
    dead = parsedJSon['dead'];
    parent = parsedJSon['parent'];
    kids = parsedJSon['kids'];
    url = parsedJSon['url'];
    score = parsedJSon['score'];
    title = parsedJSon['title'];
    descendants = parsedJSon['descendants'];
  }

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "kids": kids,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
    };
  }
}
