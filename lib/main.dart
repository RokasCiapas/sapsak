import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapsak/providers/client_provider.dart';
import 'package:sapsak/providers/sports_plan_list_provider.dart';
import 'firebase_options.dart';
import 'auth/main_page.dart';

void main() async {

  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<ClientProvider>(create: (_) => ClientProvider()),
        ListenableProxyProvider<ClientProvider, SportsPlanProvider>(
            update: (context, clientProvider, sportsPlanProvider) =>
                SportsPlanProvider(clientProvider: clientProvider))
      ],
          child: const MyApp())
  );
}

bool _isDemoUsingDynamicColors = false;

// Fictitious brand color.
const _brandYellow = Color(0xfffed813);

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightColorScheme;
          ColorScheme darkColorScheme;

          if (lightDynamic != null && darkDynamic != null) {
            // On Android S+ devices, use the provided dynamic color scheme.
            // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
            lightColorScheme = lightDynamic.harmonized();
            // (Optional) Customize the scheme as desired. For example, one might
            // want to use a brand color to override the dynamic [ColorScheme.secondary].
            lightColorScheme = lightColorScheme.copyWith(secondary: _brandYellow);
            // (Optional) If applicable, harmonize custom colors.
            lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

            // Repeat for the dark color scheme.
            darkColorScheme = darkDynamic.harmonized();
            darkColorScheme = darkColorScheme.copyWith(secondary: _brandYellow);
            darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

            _isDemoUsingDynamicColors = false; // ignore, only for demo purposes
          } else {
            // Otherwise, use fallback schemes.
            lightColorScheme = ColorScheme.fromSeed(
              seedColor: _brandYellow,
            );
            darkColorScheme = ColorScheme.fromSeed(
              seedColor: _brandYellow,
              brightness: Brightness.dark,
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ShapeShifters",
            home: const MainScreen(),
            theme: ThemeData(
              colorScheme: lightColorScheme,
              extensions: [lightCustomColors],
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme,
              extensions: [darkCustomColors],
            ),
            themeMode: ThemeMode.system,
          );
        }
    );





  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}