import 'package:builders/builders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/data/providers/memories_data_provider.dart';
import 'package:memories/modules/app/app.module.dart';
import 'package:memories/modules/app/app.widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Builders.systemInjector(Modular.get);
  await MemoriesDataProvider.init();
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
