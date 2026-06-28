import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'state/app_provider.dart';
import 'features/common/phonehub_store.dart';
import 'features/auth/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService.instance.init();
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