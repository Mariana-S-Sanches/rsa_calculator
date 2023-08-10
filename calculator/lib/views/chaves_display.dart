// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:calculator/views/rsa.dart';
import 'package:calculator/widgets/button.dart';
import 'package:calculator/widgets/alertas.dart';
import 'package:calculator/widgets/navigator.dart';
import 'package:calculator/views/tabela_ASCII.dart';
import 'package:calculator/chaves/key_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChavesDisplay extends StatefulWidget {
  const ChavesDisplay({Key? key}) : super(key: key);

  @override
  _ChavesDisplayState createState() => _ChavesDisplayState();
}

class _ChavesDisplayState extends State<ChavesDisplay> {
  int? p, q, d, n, e;
  bool emptyKeyRepo = false;

  List<String>? storedMessage = [];

  @override
  void initState() {
    getKey();
    super.initState();
  }

  getKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    p = prefs.getInt('private_key_p');
    q = prefs.getInt('private_key_q');
    d = prefs.getInt('private_key_d');
    n = prefs.getInt('public_key_n');
    e = prefs.getInt('public_key_e');
    storedMessage = prefs.getStringList('encoded_message');
    setState(() {
      if (p == null && q == null && d == null && n == null && e == null) {
        emptyKeyRepo = true;
      } else {
        emptyKeyRepo = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Wrap(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: ListTile(
                          title: Text(
                            'Mensagem armazenada:',
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.brown[700],
                            ),
                          ),
                          subtitle: Text(
                            storedMessage == null
                                ? 'Obtendo mensagem'
                                : '$storedMessage',
                            textScaleFactor: 1,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              delete_encoded_message_from_repo(messageKey: 'encoded_message');
                              storedMessage!.clear();
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete_outline,
                            ),
                            color: Colors.brown[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Chaves Privadas',
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.red[900]),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Table(
                border: TableBorder.all(
                  color: Color(0xFFB71C1C),
                  width: 1,
                ),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Chave P',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          p == null ? 'Obtendo chave' : '$p',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Chave Q',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          q == null ? 'Obtendo chave' : '$q',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Chave D',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          d == null ? 'Obtendo chave' : '$d',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Chaves Públicas',
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.green[900]),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Table(
                border: TableBorder.all(
                  color: Color(0xFF1B5E20),
                  width: 1,
                ),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Chave N',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          n == null ? 'Obtendo chave' : '$n',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Chave E',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          e == null ? 'Obtendo chave' : '$e',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: buttonCustom(
                colors: emptyKeyRepo ? Colors.brown[300] : Colors.brown[900],
                onPressed: emptyKeyRepo == true ? () {} : deleteKeys,
                text: 'Apagar Chaves',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: buttonCustom(
                onPressed: () {
                  Navigator.push(
                    context,
                    createRoute(
                      page: ASCIITable(),
                    ),
                  );
                },
                text: 'Ver tabela ASCII',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: buttonCustom(
                onPressed: () {
                  Navigator.push(
                    context,
                    createRoute(
                      page: RSADocumentation(),
                    ),
                  );
                },
                text: 'Criptografia RSA',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: Wrap(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.red[50],
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            'Atenção',
                            textScaleFactor: 1.3,
                            style: TextStyle(color: Colors.red[900]),
                          ),
                          Text(
                            'Os cálculos feitos nesse aplicativo podem não ser 100% precisos. Pode acontecer de a mensagem retornada não ser a mensagem original de fato por N fatores. Uma quantidade maior de memória e processamento é necessária para cálculos com chaves muito grandes.',
                            textScaleFactor: 1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteKeys() {
    return showDialogGeneral(
      context: context,
      title: 'Atenção',
      dismissible: true,
      firstAction: 'Sim',
      secondAction: 'Não',
      firstCallback: () {
        clearKeys();
        Navigator.pop(context);
      },
      buttonOne: Colors.brown[900],
      buttonTwo: Colors.brown[300],
      subtitle: 'Deseja apagar as chaves registradas no sistema?\nEsta ação não pode ser desfeita.',
      secondCallback: () {
        Navigator.pop(context);
      },
    );
  }

  Future<dynamic> clearKeys() async {
    delete_encoded_message_from_repo(messageKey: 'encoded_message');
    delete_key_from_repo(keyIdentificator: 'private_key_p');
    delete_key_from_repo(keyIdentificator: 'private_key_q');
    delete_key_from_repo(keyIdentificator: 'private_key_d');
    delete_key_from_repo(keyIdentificator: 'public_key_n');
    delete_key_from_repo(keyIdentificator: 'public_key_e');
    initState();
    setState(() {});
  }
}
