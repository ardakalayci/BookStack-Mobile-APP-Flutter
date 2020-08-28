import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wikiappgedik/bookmodel.dart';
import 'package:http/http.dart' as http;

class Detay extends StatefulWidget {
  int id;

  Detay(this.id,Key key) : super(key: key);


  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {

  Books bilgi;
  bool geldi =false;
  var yazi;


  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  @override
  void initState() {
    postAt(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Wiki Gedik"),
      ),
      body: SingleChildScrollView(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: geldi ? Html(
            data: yazi,
            //Optional parameters:


          ):CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Future<void> postAt(id) async {


    String baseUrl = "http://wiki.gedik.com.tr/api/books/$id/export/html";

    final http.Client httpClient = http.Client();




    final radyoUrl = baseUrl;
    http.Response radyoCevap = await httpClient.get(radyoUrl,
      headers: {"Authorization":"Token bMGv48Tt2gTI2gfnGwft3QflmXoMxvnc:qqZucz2u5Q5ggGewPd5KLZ23W0eVuOoA"},

    );
    if (radyoCevap.statusCode != 200) {
      debugPrint(radyoCevap.body.toString());
      throw Exception("Radyo  Apisi Geteirilemedi");
    }

    setState(() {

      //yazi=radyoCevap.body;
      yazi=radyoCevap.body.toString();

      geldi=true;
    });



  }
}
