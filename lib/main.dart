import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IBMI',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext _context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}
