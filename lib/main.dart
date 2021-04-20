import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpsons/Quote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simpson Quotes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = getQuote();
  }

  Future<Quote> getQuote() async {
    final response =
        await http.get(Uri.https('thesimpsonsquoteapi.glitch.me', 'quotes'));
    var responseBody = response.body
        .toString(); //.replaceFirst('[', '').replaceFirst(']', '');
    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('Failed to load quote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Colors.white54,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder<Quote>(
                        future: futureQuote,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Text(
                                  snapshot.data.character,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "\"${snapshot.data.quote}\"",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Image.network(
                                  snapshot.data.image.toString(),
                                  height: 300.0,
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureQuote = getQuote();
                      });
                    },
                    child: Text('Load new Quote')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
