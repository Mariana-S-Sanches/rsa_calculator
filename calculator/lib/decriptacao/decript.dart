class DecriptMessageService {
  int? d = 0;
  int? n = 0;

  List<dynamic> decriptedASCIImsg = [];
  List<dynamic> decriptedRSAMessage = [];

  DecriptMessageService({
    required this.d,
    required this.n,
    required this.decriptedASCIImsg,
  });

  List<dynamic>? decript() {
    // ignore: avoid_function_literals_in_foreach_calls
    decriptedASCIImsg.forEach((msg) {
      String actualASCII = msg.toString().replaceAll('.0', '');
      int a = int.parse(actualASCII);
      String a2 = a.toString();

      BigInt? m = BigInt.parse(a2);
      BigInt parsedN = BigInt.parse(n!.toString());

      BigInt m2 = m.pow(d!);

      var rest = m2.remainder(parsedN);
      decriptedRSAMessage.add(rest.toInt());
    });

    return decriptedRSAMessage;
  }
}
