class ASCIIModel{
  String? char;
  int? code;

  ASCIIModel({this.char, this.code});

  ASCIIModel.fromJson(Map<String, dynamic> json) {
    char = json['char'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['char'] = char;
    data['code'] = code;
    return data;
  }
}