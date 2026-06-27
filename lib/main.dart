import 'package:flutter/material.dart';
import 'app.dart';
import 'features/common/phonehub_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PhoneHubStore.instance.init();
  runApp(const PhoneShopApp());
}