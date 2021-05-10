import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainScreen.dart';
import 'DataHandle/appData.dart';
Future <void> main()async
{ WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

DatabaseReference usersRef=FirebaseDatabase.instance.reference().child("Customers");
DatabaseReference usersRef2=FirebaseDatabase.instance.reference().child("Drivers");


class MyApp extends StatefulWidget {
static void setLocale(BuildContext context, Locale newlocale)
{
  _MyAppState state=context.findRootAncestorStateOfType<_MyAppState>();
}
  @override

  _MyAppState createState()=>_MyAppState();
}
class  _MyAppState extends State<MyApp>
{

  @override
  Widget build(BuildContext flcontext) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Main ',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: MainScreen(),
      ),
    );
  }
}
