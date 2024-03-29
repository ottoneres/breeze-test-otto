import 'package:breeze_case/core/router/router.dart';
import 'package:breeze_case/ui/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.read(routerProvider),
      title: 'Breeze Case',
      theme: BreezeTheme.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
