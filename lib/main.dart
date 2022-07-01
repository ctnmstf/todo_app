import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repo/todo_repo.dart';
import 'package:todo_app/view/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ToDoRepo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('tr', ''),
        ],
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.lightBlue,
            primaryColor: Colors.lightBlue,
            primaryColorLight: Colors.lightBlueAccent,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.lightBlueAccent,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
                iconTheme: IconThemeData(color: Colors.white)),
            inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
              alignLabelWithHint: true,
            )),
        home: const Home(),
      ),
    );
  }
}
