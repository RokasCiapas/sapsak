import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'package:sapsak/shared/theme.dart';
import 'firebase_options.dart';
import 'auth/main_page.dart';

void main() async {

  /// initialize FireBase App
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ClientProvider>(create: (_) => ClientProvider()),
      // ChangeNotifierProvider<SportsPlanProvider>(create: (_) => SportsPlanProvider()),
      ListenableProxyProvider<ClientProvider, SportsPlanProvider>(
          update: (context, clientProvider, sportsPlanProvider) =>
          SportsPlanProvider(clientProvider: clientProvider))
    ],
    child: const MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final settings = ValueNotifier(ThemeSettings(
    sourceColor: const Color(0xfffed813),
    themeMode: ThemeMode.system,
  ));

  @override
  Widget build(BuildContext context) {

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => ThemeProvider(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
          settings: settings,
          child: NotificationListener<ThemeSettingChange>(
            onNotification: (notification) {
              settings.value = notification.settings;
              return true;
            },
            child: ValueListenableBuilder<ThemeSettings>(
              valueListenable: settings,
              builder: (context, value, _) {
                final theme = ThemeProvider.of(context);

                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "ShapeShifters",
                  home: const MainScreen(),
                  themeMode: theme.themeMode(),
                  theme: theme.light(settings.value.sourceColor),
                  darkTheme: theme.dark(settings.value.sourceColor),
                );
              },
            ),
          )
      ),
    );





  }
}