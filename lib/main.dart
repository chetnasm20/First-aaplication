import 'package:careercounselling/helper/authentication.dart';
import 'package:careercounselling/helper/functions.dart';
import 'package:careercounselling/users_data.dart';
import 'package:careercounselling/views/home.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedin = false;
  @override
  void initState(){
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async{
    HelperFunctions.getUserLoggedInDetails().then((value){
      setState((){
        _isLoggedin = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedin) ? Home() : Authenticate(),
    );
  }
}
