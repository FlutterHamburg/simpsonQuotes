import 'package:flutter/cupertino.dart';

class Quote {
  final String quote;
  final String character;
  final String image;
  final String characterDirection;

  Quote(
      {@required this.quote,
      @required this.character,
      @required this.image,
      @required this.characterDirection});

  factory Quote.fromJson(var json) {
    return Quote(
        quote: json[0]['quote'],
        character: json[0]['character'],
        image: json[0]['image'],
        characterDirection: json[0]['characterDirection']);
  }
}
