// ignore_for_file: prefer_const_constructors

import 'ASCII/ascii.dart';
import 'ASCII/ascii_model.dart';
import 'views/decriptar_mensagem.dart';
import 'package:flutter/material.dart';
import 'package:calculator/views/chaves.dart';
import 'package:calculator/views/chaves_display.dart';
import 'package:calculator/views/encriptar_mensagem.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      locale: const Locale(
        'pt',
        'BR',
      ),
      supportedLocales: const [
        Locale("pt"),
      ],
      theme: ThemeData(
        fontFamily: 'FontCustom',
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown[900],
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  ASCII? ascii;
  List<ASCIIModel?>? asciiModel;

  MyHomePage({Key? key}) : super(key: key) {
    ascii = ASCII();
    asciiModel = [];
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 1;
  var _pages = [];

  @override
  void initState() {
    _pages = [
      ChavesScreen(),
      ChavesDisplay(),
      EncriptMessage(),
      DecriptMessage(),
    ];
    super.initState();
  }

  void onTap(int i) {
    setState(() {
      _index = i;
    });
  }

  Widget buildPages(int index) {
    return _pages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: const Text('RSA'),
        centerTitle: true,
      ),
      body: buildPages(_index),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: _index,
        selectedItemColor: Colors.brown[800],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.brown.shade300,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key_sharp),
            label: 'Definir chaves',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: 'Arquivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield_outlined),
            label: 'Encriptar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_moderator_outlined),
            label: 'Decriptar',
          ),
        ],
      ),
    );
  }
}
