//importar biblioteca material.dart
//possui elementos gráficos e widgets
//text, button etc.
import 'dart:html';
import 'package:flutter/material.dart';

//Ponto de entrada da App
//runApp informa ao flutter para executar este widget como aplicação
void main() {
  runApp(const MyApp());
}

//classe MyApp que herda atributos de StatelessWidget (extends)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

//método descreve qual interface será apresentada na tela inicial
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          //Título do App
          title: const Text('Meu primeiro app'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Hello World!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Digite seu usuário',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                //obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'Digita sua senha',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('Botão pressionado!');
                },
                child: const Text('Clique aqui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
