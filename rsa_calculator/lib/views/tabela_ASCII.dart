// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rsa_calculator/ASCII/ascii.dart';
import 'package:rsa_calculator/ASCII/ascii_model.dart';

// ignore: must_be_immutable
class ASCIITable extends StatefulWidget {
  ASCII? ascii;

  ASCIITable({Key? key}) : super(key: key) {
    ascii = ASCII();
  }

  @override
  _ASCIITableState createState() => _ASCIITableState();
}

class _ASCIITableState extends State<ASCIITable> {
  List<ASCIIModel>? asciiModel = [];

  @override
  void initState() {
    asciiRsa();
    widget.ascii?.assertCharOfRSA().then((result) {
      setState(() {
        asciiModel = result.cast<ASCIIModel>();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('Tabela ASCII'),
        centerTitle: true,
        bottom: PreferredSize(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  'Código do Caractere',
                  textScaleFactor: 1.3,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, bottom: 10),
                child: Text(
                  'Caractere',
                  textScaleFactor: 1.3,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(40),
        ),
      ),
      body: asciiModel == null || asciiModel!.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: asciiModel!.length,
              itemBuilder: (ctx, i) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: (i % 2) == 0 ? Colors.brown[100] : Colors.white),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text(
                            asciiModel![i].code!.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Text(
                            asciiModel![i].char!.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<dynamic> asciiRsa() async {
    return await widget.ascii?.assertCharOfRSA();
  }
}
