import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  String resposta = "";
  String respostaWeb = "";
  String cep = "";
  TextEditingController cidade = TextEditingController();

  getDados(cep) async {
    String urlApi = "https://viacep.com.br/ws/$cep/json/";
    http.Response response = await http.get(Uri.parse(urlApi));
    Map<String, dynamic> resposta = json.decode(response.body);

    setState(() {
      respostaWeb = "Rua: ${resposta['logradouro']},\n Bairro: ${resposta['bairro']},\n Complemento: ${resposta['complemento']},\n localidade: ${resposta['localidade']},\n UF: ${resposta["uf"]},\n ibge: ${resposta['ibge']},\n ddd: ${resposta['ddd']}\n ";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultor de CEP"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: cidade,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Informe o CEP",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  getDados(cep);
                  setState(() {
                    cep = cidade.text;
                  });
                },
                child: Text("Procurar",style: TextStyle(
                  fontSize: 20
                ),),
              ),
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Text(respostaWeb,style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),)
          ],
        ),
      ),
    );
  }
}
