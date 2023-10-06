import 'dart:math';

class Target {
  late String id;
  late String title;
  late DateTime startTime;
  List<RegisTarget> history = [];

  Target() {
    id = (100000 + Random().nextInt(100000)).toString();
    title = "";
    startTime = DateTime.now();
  }

  Target.fromMap(Map data) {
    id = data["id"];
    title = data["title"];
    startTime = data["startTime"];
    history =
        (data["history"] as List).map((e) => RegisTarget.fromMap(e)).toList();
  }

  Map toMap() {
    return {
      "id": id,
      "title": title,
      "startTime": startTime,
      "history": history.map((e) => e.toMap()).toList(),
    };
  }
}

class RegisTarget {
  late String detail;
  late DateTime regisTime;

  RegisTarget() {
    detail = "";
    regisTime = DateTime.now();
  }

  RegisTarget.fromMap(Map data) {
    detail = data["detail"];
    regisTime = data["regisTime"];
  }

  Map toMap() {
    return {
      "detail": detail,
      "regisTime": regisTime,
    };
  }
}
