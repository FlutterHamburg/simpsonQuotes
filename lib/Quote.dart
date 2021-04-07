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
        quote: json['quote'],
        character: json['character'],
        image: json['image'],
        characterDirection: json['characterDirection']);
  }
}
