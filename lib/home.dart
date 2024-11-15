import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    String _resultado = "Resultado";

    TextEditingController _controllerCep = TextEditingController();

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = 'https://viacep.com.br/ws/${cepDigitado}/json/';
    http.Response response;

    response = await http.get(
      Uri.parse(url),
    );

    json.decode(response.body);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });

    print(
      "Resposta logradouro: ${logradouro} complemento: ${complemento} bairro: ${bairro} localidade: ${localidade}"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de servico web'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: Ex: 85501530",
              ),
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _controllerCep,
            ),
            ElevatedButton(
              onPressed: _recuperarCep,
              child: const Text('Clique aqui'),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
