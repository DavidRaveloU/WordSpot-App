import 'package:flutter/material.dart';
import 'package:wordspot/pages/home_page.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(useMaterial3: true));
  }
}
