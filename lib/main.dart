
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'net/data.dart';
import 'screens/welcome/welcome_screen.dart';
import 'routes.dart';
import 'theme.dart';

Future<void> main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => Data(),
    child: MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"),
        Locale('en', ''),
      ],
      locale: Locale("fa", "IR"),
      theme: theme(),
      initialRoute: WelcomeScreen.routeName,
      routes: routes,
    ),
  ));
}
