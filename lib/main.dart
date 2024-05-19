import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:series_list_app/my_series.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MyApp());
  });
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.lightGreen);
  var kDarkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 42, 54, 9),
      brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr'),
          Locale('en'),
        ],
        darkTheme: ThemeData.dark().copyWith(colorScheme: kDarkColorScheme),
        theme: ThemeData().copyWith(
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            )),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge:
                      TextStyle(color: kColorScheme.onSecondaryContainer),
                  titleMedium: TextStyle(
                      color: kColorScheme.onTertiaryContainer, fontSize: 18),
                )),
        themeMode: ThemeMode.system,
        home: const MySeries(
          title: 'My Series',
        ));
  }
}
