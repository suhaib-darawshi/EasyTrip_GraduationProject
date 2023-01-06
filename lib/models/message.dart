import 'dart:convert';

class Message {
  String text;
  bool isSender;
  Message({
    required this.text,
    required this.isSender,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isSender': isSender,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      isSender: map['isSender'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));
}
