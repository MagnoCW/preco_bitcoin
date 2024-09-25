import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String valor = 'valor';

  void _atualizarPreco() async {

    String url = 'https://blockchain.info/ticker';
    http.Response response;

    response = await http.get(Uri.parse(url));
    
    Map <String, dynamic> retorno = jsonDecode(response.body);

    Map<String, dynamic> brlData = retorno['BRL'];
    
    String quinzeM = brlData['15m'].toString();
    String last = brlData['last'].toString();
    String buy = brlData['buy'].toString();
    String sell = brlData['sell'].toString();
    String symbol = brlData['symbol'].toString();

    setState(() {
      valor = buy;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('lib/images/bitcoin.png'),
            Text(
              'R\$ $valor',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                _atualizarPreco();
              }, 
              child: Text(
                'Atualizar', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}