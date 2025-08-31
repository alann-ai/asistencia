import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/app_localizations.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AssistiveAIApp());
}

class AssistiveAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asistente Universal IA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', ''), // Español
        Locale('en', ''), // English
        Locale('zh', ''), // 中文
        Locale('ko', ''), // 한국어
        Locale('fr', ''), // Français
        Locale('de', ''), // Deutsch
        Locale('ja', ''), // 日本語
        Locale('pt', ''), // Português
        Locale('ru', ''), // Русский
        Locale('ar', ''), // العربية
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}