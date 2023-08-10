class EncriptMessageService {
  int? e = 0;
  int? n = 0;

  List<dynamic> encriptedASCIImsg = [];
  List<dynamic> encriptedRSAMessage = [];

  EncriptMessageService({
    required this.e,
    required this.n,
    required this.encriptedASCIImsg,
  });

  List<dynamic>? encript() {
    // ignore: avoid_function_literals_in_foreach_calls
    encriptedASCIImsg.forEach((msg) {
      String actualASCII = msg.toString();
      BigInt? m = BigInt.parse(actualASCII);
      BigInt parsedN = BigInt.parse(n!.toString());

      BigInt m2 = m.pow(e!);

      var rest = m2.remainder(parsedN);
      encriptedRSAMessage.add(rest.toDouble());
    });

    return encriptedRSAMessage;
  }
}
