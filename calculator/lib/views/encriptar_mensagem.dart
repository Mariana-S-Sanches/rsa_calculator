// ignore_for_file: prefer_const_constructors

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:calculator/ASCII/ascii.dart';
import 'package:calculator/widgets/button.dart';
import 'package:calculator/widgets/alertas.dart';
import 'package:calculator/ASCII/ascii_model.dart';
import 'package:calculator/encriptacao/encript.dart';
import 'package:calculator/chaves/key_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class EncriptMessage extends StatefulWidget {
  ASCII? ascii;
  List<ASCIIModel?>? asciiModel;

  EncriptMessage({Key? key}) : super(key: key) {
    ascii = ASCII();
    asciiModel = [];
  }

  @override
  _EncriptMessageState createState() => _EncriptMessageState();
}

class _EncriptMessageState extends State<EncriptMessage> {
  TextEditingController message = TextEditingController();
  int? e = 0;
  int? n = 0;
  int? d = 0;

  bool isEncripted = false;

  double c = 0;

  List<dynamic>? encriptedRSAMessage = [];
  List<dynamic> encriptedASCIIMessage = [];

  @override
  void initState() {
    asciiRsa();
    widget.ascii?.assertCharOfRSA().then((result) {
      setState(() {
        widget.asciiModel = result.cast<ASCIIModel?>();
      });
    });
    getKey();

    super.initState();
  }

  getKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    e = prefs.getInt('public_key_e');
    n = prefs.getInt('public_key_n');
    d = prefs.getInt('private_key_d');
  }

  unfocus() {
    var currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: unfocus,
              child: TextFormField(
                controller: message,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.brown[300]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Mensagem a ser encriptada',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: buttonCustom(
                onPressed: () {
                  var currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  convertToASCII();
                  encriptMessage();
                  setState(() {
                    isEncripted = true;
                  });
                },
                text: 'Encriptar mensagem',
              ),
            ),
            encriptedASCIIMessage.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mensagem ASCII:',
                          textScaleFactor: 1.3,
                        ),
                        Wrap(
                          children: [
                            Text(
                              '$encriptedASCIIMessage',
                              textScaleFactor: 1.3,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            encriptedRSAMessage!.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mensagem Codificada:',
                          textScaleFactor: 1.3,
                        ),
                        Wrap(
                          children: [
                            Text(
                              '$encriptedRSAMessage',
                              textScaleFactor: 1.3,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            isEncripted
                ? Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: buttonCustom(
                      onPressed: () {
                        List<String> rsaMsg = [];
                        for (var rsa in encriptedRSAMessage!) {
                          double aa = rsa;
                          rsaMsg.add(aa.toString());
                        }
                        showDialogGeneral(
                          context: context,
                          title: 'Mensagem Armazenada!',
                          dismissible: true,
                          firstAction: 'OK',
                          buttonOne: Colors.brown[900],
                          subtitle: 'Agora você pode usá-la na sessão de decriptação do App.',
                          firstCallback: () {
                            Navigator.pop(context);
                          },
                        );
                        storeEncoded_Message(message: rsaMsg);
                      },
                      text: 'Guardar mensagem',
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  convertToASCII() {
    encriptedASCIIMessage.clear();
    String msg = message.text;
    List<String> msgList = [];
    for (int i = 0; i < msg.length; i++) {
      String substring = msg.substring(i, i + 1);
      msgList.add(substring);

      widget.asciiModel?.forEach((ascii) {
        if (ascii?.char == substring) {
          encriptedASCIIMessage.add(ascii?.code);
        }
      });
      setState(() {});
    }
  }

  encriptMessage() async {
    var rsa = await EncriptMessageService(
      n: n,
      e: e,
      encriptedASCIImsg: encriptedASCIIMessage,
    ).encript();
    setState(() {
      encriptedRSAMessage = rsa;
    });
  }

  Future<dynamic> asciiRsa() async {
    return await widget.ascii?.assertCharOfRSA();
  }
}
