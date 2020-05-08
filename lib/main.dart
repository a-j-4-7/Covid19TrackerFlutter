import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/ui/screens/main/mainpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: MyColors.appBgColor,
        ),
        home: MainPage(),
      ),
    );
  }
}
