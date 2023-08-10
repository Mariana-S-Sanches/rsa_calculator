// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RSADocumentation extends StatefulWidget {
  @override
  _RSADocumentationState createState() => _RSADocumentationState();
}

class _RSADocumentationState extends State<RSADocumentation> {
  bool card1 = false;
  bool card2 = false;
  bool card3 = false;
  bool card4 = false;
  EdgeInsets paddingText = EdgeInsets.only(top: 10, bottom: 20, left: 30, right: 30);

  textPresset({required String text}) {
    return Text(
      text,
      textScaleFactor: 1.1,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.brown[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('Criptografia RSA'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        controller: ScrollController(),
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(30),
        children: [
          Padding(
            padding: paddingText,
            child: Text(
              'Sendo mundialmente conhecida por sua segurança e baseada em princípios matemáticos, a Criptografia RSA é um cripto-sistema muito usado na transmissão de dados.',
              textScaleFactor: 1.1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.brown[700],
              ),
            ),
          ),
          Padding(
            padding: paddingText,
            child: Text(
              'Criada em 1977, por  Ron Rivest, Adi Shamir e Leonard Adleman, RSA é um cripto-sistema de Chave Pública, ou mais conhecido como Chave Assimétrica, e se consiste em quatro etapas:',
              textScaleFactor: 1.1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.brown[700],
              ),
            ),
          ),
          expansionCardKeyGeneration(),
          expansionCardKeyDistribuition(),
          expansionCardEncript(),
          expansionCardDecript(),
        ],
      ),
    );
  }

  expansionCardKeyGeneration() {
    EdgeInsets pdd = EdgeInsets.only(top: 0, bottom: 20, left: 30, right: 30);

    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: ExpansionPanelList(
        expansionCallback: (int i, bool expanded) {
          setState(() {
            card1 = !expanded;
          });
        },
        animationDuration: Duration(milliseconds: 800),
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'As chaves para encriptação do RSA se consistem em 5: duas públicas e três privadas, onde:',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'É necessário que existam dois números primos, denominados Chave Privada P e Chave Privada Q, para o encontro das próximas chaves. Estes dois se tornam nossas primeiras chaves privadas, e, por isso, não devem ser compartilhados com ninguém.',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Em seguida fazemos o cálculo da primeira chave pública, que denominamos como Chave Pública N, que nada mais é do que o produto das duas chaves privadas. ',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/pq_prime.png',
                        width: 100,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Tendo encontrado a chave N, agora devemos calcular a função Totiente da chave N, que se consiste basicamente em:',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/form_totiete.png',
                        width: 180,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'A partir do resultado obtido de 𝜑(N), devemos escolher um número que seja maior que 1, que não possua divisores comuns além do 1, e que seja menor que o número encontrado anteiormente. Esse número será a chave pública E.',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'A seguir, para encontrar o valor da Chave Privada D, devemos fazer um cáculo comumente chamado de inverso modular. Este se baseia em encontrar um número que, ao ser multiplicado pela chave pública E, apresente resto 1, ao ser dividido pela 𝜑(N).',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/dxe.png',
                        width: 180,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'É somente após o encontro desses 5 valores que a encriptação pode acontecer.',
                  ),
                ),
              ],
            ),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Geração de Chaves',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.brown[700],
                  ),
                ),
              );
            },
            isExpanded: card1,
          ),
        ],
      ),
    );
  }

  expansionCardKeyDistribuition() {
    EdgeInsets pdd = EdgeInsets.only(top: 0, bottom: 20, left: 30, right: 30);
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: ExpansionPanelList(
        expansionCallback: (int i, bool expanded) {
          setState(() {
            card2 = !expanded;
          });
        },
        animationDuration: Duration(milliseconds: 800),
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'Suponha que uma parte A, queira enviar dados à uma parte B. Para isso, a parte B deve saber a chave pública de A e A deve usar a chave privada para descriptografar a mensagem.',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Para que B consiga enviar mensagens para A, este deve fornecer as chaves públicas N e E, e em hipótese alguma a chave D da parte A deve ser revelada.',
                  ),
                ),
              ],
            ),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Distribuição de Chaves',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.brown[700],
                  ),
                ),
              );
            },
            isExpanded: card2,
          ),
        ],
      ),
    );
  }

  expansionCardEncript() {
    EdgeInsets pdd = EdgeInsets.only(top: 0, bottom: 20, left: 30, right: 30);
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: ExpansionPanelList(
        expansionCallback: (int i, bool expanded) {
          setState(() {
            card3 = !expanded;
          });
        },
        animationDuration: Duration(milliseconds: 800),
        children: [
          ExpansionPanel(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'A fase de encriptação do texto se consiste em transformar a mensagem em ASCII, baseado no código de cada caractere na tabela. Codificaremos a palavra "Cripto".',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Neste exemplo nossas chaves serão:',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: textPresset(
                        text: 'Chave P = 13',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: textPresset(
                        text: 'Chave Q = 11',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: textPresset(
                        text: 'Chave D = 107',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: textPresset(
                        text: 'Chave N = 143',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: textPresset(
                        text: 'Chave E = 83',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'Quando essa palavra é convertida em código ASCII, recebemos a seguinte cadeia de números: 67, 114, 105, 112, 116, 111. Cada número corresponde à letra da mensagem, e será tratado como bloco M.',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Agora devemos pegar um bloco M e para encriptar a mensagem, vamos começar com 67. ',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Denominaremos como C o bloco codificado que obteremos após aplicar a fórmula: ',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/equation_two.png',
                        width: 180,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/equation_one.png',
                        width: 180,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Após esse cálculo, obteremos como resultado o valor 111. Seguindo essa mesma fórmula em todos os blocos, receberemos a mensagem: 111, 108, 40, 96, 51, 67',
                  ),
                ),
              ],
            ),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Encriptação',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.brown[700],
                  ),
                ),
              );
            },
            canTapOnHeader: true,
            isExpanded: card3,
          ),
        ],
      ),
    );
  }

  expansionCardDecript() {
    EdgeInsets pdd = EdgeInsets.only(top: 0, bottom: 20, left: 30, right: 30);
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      child: ExpansionPanelList(
        expansionCallback: (int i, bool expanded) {
          setState(() {
            card4 = !expanded;
          });
        },
        animationDuration: Duration(milliseconds: 800),
        children: [
          ExpansionPanel(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'A fase de decriptação da mensagem se consiste em realizar o caminho inverso da encriptação. Aqui, devemos pegar cada bloco codificado na fase de encriptação( 111, 108, 40, 96, 51, 67), e aplicar a mesma fórmula em cada.',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/equation_tree.png',
                        width: 150,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: pdd,
                      child: Image.asset(
                        'assets/equation_four.png',
                        width: 180,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text:
                        'Após este processo, nosso primeiro bloco descriptografado resultará em 67, sendo este o código ASCII apresentado anteriormente, e fazendo o mesmo processo nos outros blocos, receberemos: 67, 114, 105, 112, 116, 111.',
                  ),
                ),
                Padding(
                  padding: pdd,
                  child: textPresset(
                    text: 'Verificando a tabela ASCII, e assimilando cada bloco a seu devido código receberemos a mensagem "Cripto" de volta.',
                  ),
                ),
              ],
            ),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Decriptação',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.brown[700],
                  ),
                ),
              );
            },
            canTapOnHeader: true,
            isExpanded: card4,
          ),
        ],
      ),
    );
  }
}
