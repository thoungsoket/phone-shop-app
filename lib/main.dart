import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'state/app_provider.dart';
import 'features/common/phonehub_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PhoneHubStore.instance.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const PhoneShopApp(),
    ),
  );
}