// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:calculator/chaves/key_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculator/ASCII/ascii.dart';
import 'package:calculator/widgets/button.dart';
import 'package:calculator/ASCII/ascii_model.dart';
import 'package:calculator/decriptacao/decript.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DecriptMessage extends StatefulWidget {
  ASCII? ascii;
  List<ASCIIModel?>? asciiModel;

  DecriptMessage({Key? key}) : super(key: key) {
    ascii = ASCII();
    asciiModel = [];
  }
  @override
  _DecriptMessageState createState() => _DecriptMessageState();
}

class _DecriptMessageState extends State<DecriptMessage> {
  TextEditingController message = TextEditingController();
  int? n = 0;
  int? d = 0;

  double c = 0;

  bool decript = false;

  String finalMessage = '';
  String decriptedRSAMessageText = '';

  List<int?>? keys = [];

  List<dynamic>? encoded_message = [];
  List<dynamic>? decriptedRSAMessage = [];
  List<dynamic> decriptedASCIIMessage = [];

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
      body: GestureDetector(
        onTap: unfocus,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Mensagem a ser decriptada: ',
                  textScaleFactor: 1.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  '(Separe cada bloco por hífen)',
                  textScaleFactor: 0.9,
                ),
              ),
              TextFormField(
                controller: message,
                maxLines: null,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.brown[300]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Mensagem',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: buttonCustom(
                  onPressed: () {
                    decriptMessage(message: message.text);
                  },
                  text: 'Decriptar Mensagem',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: buttonCustom(
                  onPressed: () {
                    use_Encoded_Store_Message();
                  },
                  text: 'Usar mensagem armazenada',
                ),
              ),
              decriptedRSAMessage!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Mensagem ASCII:',
                              textScaleFactor: 1.3,
                            ),
                          ),
                          Wrap(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  color: Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    decriptedRSAMessageText,
                                    textScaleFactor: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              finalMessage != ''
                  ? Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Mensagem Original:',
                              textScaleFactor: 1.3,
                            ),
                          ),
                          Wrap(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  color: Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    finalMessage,
                                    textScaleFactor: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  use_Encoded_Store_Message() async {
    List<String>? encodedMsg = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    encodedMsg = prefs.getStringList('encoded_message');
    message.text = encodedMsg.toString();
    encoded_message!.clear();
    for (var e in encodedMsg!) {
      double msg = double.parse(e);
      encoded_message!.add(msg);
    }
  }

  decriptMessage({String? message}) async {
    if (message != null || message != '') {
      String mS = message!.replaceAll('[', '');
      String mS2 = mS.replaceAll(']', '');
      String mm = mS2.replaceAll('-', ',');
      String msg = mm.replaceAll('.0', '');
      List<String>? msgList = msg.split(',');
      List<dynamic> finalMsgList = [];
      for (var e in msgList) {
        int ei = int.parse(e);
        finalMsgList.add(ei);
      }

      var rsa = DecriptMessageService(
        n: n,
        d: d,
        decriptedASCIImsg: msgList,
      ).decript();
      setState(() {
        decriptedRSAMessage = rsa;
        String message = decriptedRSAMessage.toString();
        var a = message.replaceAll('[', '');
        decriptedRSAMessageText = a.replaceAll(']', '');
        convertToASCII();
      });
    } else {
      var rsa = DecriptMessageService(
        n: n,
        d: d,
        decriptedASCIImsg: encoded_message!,
      ).decript();
      setState(() {
        decriptedRSAMessage = rsa;
        String message = decriptedRSAMessage.toString();
        var a = message.replaceAll('[', '');
        decriptedRSAMessageText = a.replaceAll(']', '');
        convertToASCII();
      });
    }
  }

  convertToASCII() {
    finalMessage = '';
    decriptedASCIIMessage.clear();
    for (var msgRSA in decriptedRSAMessage!) {
      widget.asciiModel?.forEach((ascii) {
        if (ascii?.code == msgRSA) {
          finalMessage = '$finalMessage${ascii?.char}';
          decriptedASCIIMessage.add(ascii?.char);
        }
      });
      setState(() {});
    }
  }

  Future<dynamic> asciiRsa() async {
    return await widget.ascii?.assertCharOfRSA();
  }
}
