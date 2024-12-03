import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/bmi_page.dart';
import 'package:ibmi/pages/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = [BmiPage(), History()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("IBMI"),
        ),
        child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: "BMI"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: "History")
            ]),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                builder: (context) {
                  
                  return _tabs[index];
                },
              );
            }));
  }
}
