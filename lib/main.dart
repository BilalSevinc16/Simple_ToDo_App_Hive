import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'home.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<Map>("target");
  runApp(const Home());
}
