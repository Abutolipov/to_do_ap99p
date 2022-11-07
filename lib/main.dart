import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/splash.dart';
import 'package:easy_localization/easy_localization.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales:const [
          Locale('en', 'US'),
          Locale('uz', 'UZ'),
          Locale('ru', 'RU'),
        ],
        path: 'assets/translation',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode:ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.white,

      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home:MyCustomWidget(),
    );
  }
}
