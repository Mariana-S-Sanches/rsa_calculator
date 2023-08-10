// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:calculator/widgets/button.dart';
import 'package:calculator/widgets/alertas.dart';
import 'package:calculator/chaves/key_repository.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ChavesScreen extends StatefulWidget {
  const ChavesScreen({Key? key}) : super(key: key);

  @override
  _ChavesScreenState createState() => _ChavesScreenState();
}

class _ChavesScreenState extends State<ChavesScreen> {
  TextEditingController primoP = TextEditingController();
  TextEditingController primoQ = TextEditingController();
  TextEditingController publicaE = TextEditingController();

  bool isSaved = false;

  int p = 0;
  int q = 0;
  int n = 0;
  int d = 0;
  int tn = 0;
  List<int> e = [];

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
          padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text('Chave privada P:'),
              ),
              TextFormField(
                keyboardType: TextInputType.number, //numberWithOptions(signed: true, decimal: true),
                textInputAction: TextInputAction.done,
                onChanged: (keyp) {
                  p = int.parse(primoP.text);
                  keyN();
                  keyTotientN();
                  checkPrime();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (inputP) {
                  if (inputP == '') {
                    return 'Insira a chave P';
                  } else {
                    int inputs = int.parse(inputP!);
                    for (int i = 2; i <= inputs; i++) {
                      if (inputs % i == 0) {
                        return '$inputs não é um número primo';
                      } else {
                        return null;
                      }
                    }
                  }
                },
                controller: primoP,
                decoration: InputDecoration(
                  hintText: 'Chave privada P',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.brown[300]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  'Chave privada Q:',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (keyq) {
                  q = int.parse(primoQ.text);

                  keyN();
                  keyTotientN();
                  checkPrime();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (inputQ) {
                  if (inputQ == '') {
                    return 'Insira a chave Q';
                  } else {
                    int inputs = int.parse(inputQ!);
                    for (int i = 2; i <= inputs; i++) {
                      if (inputs % i == 0) {
                        return '$inputs não é um número primo';
                      } else {
                        return null;
                      }
                    }
                  }
                },
                controller: primoQ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.brown[300]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Chave privada Q',
                ),
              ),
              ListTile(
                title: Text('Chave pública N'),
                trailing: Text(
                  n != 0 ? '$n' : 'aguardando',
                ),
              ),
              ListTile(
                title: Text('Função Totiente de N'),
                trailing: Text(
                  tn != 0 ? '$tn' : 'aguardando',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text('Chave pública E:  '),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (keye) {
                  checkPrime();
                  modularInversion();
                  setState(() {});
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (inputE) {
                  if (inputE == '') {
                    return 'Insira a chave E';
                  } else {
                    int inputs = int.parse(inputE!);
                    if (inputs > tn) {
                      return 'Escolha um número entre 1 e $tn';
                    } else {
                      return null;
                    }
                  }
                },
                controller: publicaE,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.brown[300]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Chave pública E',
                ),
              ),
              e.isEmpty
                  ? SizedBox()
                  : Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                            10,
                          ),
                          child: Text(
                            '$e',
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              ListTile(
                title: Text('Chave D - Inverso Multiplicativo'),
                trailing: Text(
                  d != 0 ? '$d' : 'aguardando',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: buttonCustom(
                colors: p == 0 && q == 0 && e.isEmpty ? Colors.brown[300] : Colors.brown[900],
                onPressed: p == 0 && q == 0 && e.isEmpty ? () {} : alertStoredKeys,
                text: 'Guardar Chaves',
              ),
            ),
          ],
        ),
      ),
    );
  }

  keyN() {
    n = p * q;
    setState(() {});
  }

  keyTotientN() {
    int tp = p - 1;
    int tq = q - 1;
    tn = tp * tq;
    setState(() {});
  }

  checkPrime() {
    e.clear();
    for (int index = 0; index <= tn; index++) {
      int i, m = 0, flag = 0;

      m = index ~/ 2;
      for (i = 2; i <= m; i++) {
        if (index % i == 0) {
          flag = 1;
          break;
        }
      }
      if (flag == 0) {
        if (index > 2) {
          e.add(index);
        }
      }
    }
    setState(() {});
  }

  modularInversion() {
    int e = int.parse(publicaE.text);
    int x = 0;

    for (x = 1; x <= tn; x++) {
      if ((e * x) % tn == 1) {
        d = x;
        return x;
      }
    }
  }

  alertStoredKeys() {
    assertKeys();
    return showDialogGeneral(
      context: context,
      title: 'Chaves Armazenadas!',
      dismissible: true,
      firstAction: 'OK',
      buttonOne: Colors.brown[900],
      subtitle: 'Agora você pode usá-las para encriptar e decriptar as mensagens em RSA.',
      firstCallback: () {
        Navigator.pop(context);
      },
    );
  }

  Future assertKeys() async {
    delete_key_from_repo(keyIdentificator: 'private_key_p');
    delete_key_from_repo(keyIdentificator: 'private_key_q');
    delete_key_from_repo(keyIdentificator: 'private_key_d');
    delete_key_from_repo(keyIdentificator: 'public_key_n');
    delete_key_from_repo(keyIdentificator: 'public_key_e');

    setState(() {});

    int chav = int.parse(publicaE.text);
    //publicas
    int chaveN = n;
    int chaveE = chav;
    //privadas
    int chaveP = p;
    int chaveQ = q;
    int chaveD = d;

    storePublicKey_E(eKey: chaveE);
    storePublicKey_N(nKey: chaveN);
    storePrivateKey_P(pKey: chaveP);
    storePrivateKey_Q(qKey: chaveQ);
    storePrivateKey_D(dKey: chaveD);
  }
}
