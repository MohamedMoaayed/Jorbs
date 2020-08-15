import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Jorbs/Screens/PopUpScreen.dart';
import 'package:flutter/services.dart';

import 'Screens/AboutScreen.dart';
import 'Widgets/JobCards.dart';
import 'bloc/jorbs_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //MultiBloc becuase the app has two screens for resourcing Bloc
      providers: [
        BlocProvider<JorbsBloc>(
          create: (BuildContext context) => JorbsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Jorbs',
        //simple theme for the app
        theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: Color.fromRGBO(246, 246, 246, 1),
          accentColor: Color.fromRGBO(255, 67, 67, 1),
          fontFamily: 'Gilory',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jorbs",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.bold,
              fontSize: 50,
            )),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 00,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AboutDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: ,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Center(child: PopUpScreen()),
          SizedBox(
            height: 5,
          ),
          Text(
            "Recent Jobs ",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 50,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 7,
          ),
          Expanded(
            child: JobCards(),
          ),
        ],
      ),
    );
  }
}
