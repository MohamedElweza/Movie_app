import 'package:cut/Theme.dart';
import 'package:cut/screens/Profile/user/user_data.dart';
import 'package:flutter/material.dart';
import 'package:cut/Local/fav_sqlite/dbHelper_Save.dart';
import 'package:cut/Provider/provider.dart';
import 'package:cut/screens/Details.dart';
import 'package:cut/screens/Home.dart';
import 'package:cut/screens/Login&RegisterScreen/Login.dart';
import 'package:cut/screens/Profile.dart';
import 'package:cut/screens/Profile/pages/profile_page.dart';
import 'package:cut/screens/Saved.dart';
import 'package:cut/screens/SplashScreen.dart';
import 'package:cut/screens/tabsscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveDB.instance.open();

  final user = UserData.myUser;
  runApp(ChangeNotifierProvider<MyProvider>(
      create: (_)=> MyProvider(),
      child: user.name != null && user.Password != null? const MyApp(): const MyHome(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<MyProvider>(context).tm,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      home: SplashScreen(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<MyProvider>(context).tm,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      home: TabsScreen(),
    );
  }
}
