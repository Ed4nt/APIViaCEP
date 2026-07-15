import 'dart:convert';
import 'package:apiviacep_frontend/apiviacep_models/apiviacep_models.dart';
import 'package:http/http.dart' as http;

Future<CepModel> pegaEndereco(String cep) async {
  Uri uri = Uri.parse('https://viacep.com.br/ws/$cep/json/');
  http.Response response = await http.get(uri);
  Map json = jsonDecode(response.body);
  CepModel endereco = CepModel.fromJson(json);
  return endereco;
}

Future<CepModel> pegaCep(String uf, String cidade, String logradouro, String bairro) async {
  if (bairro.isEmpty) {
    Uri uri = Uri.parse('https://viacep.com.br/ws/$uf/$cidade/$logradouro/json/');
    http.Response response = await http.get(uri);
    Map json = jsonDecode(response.body);
    CepModel endereco = CepModel.fromJson(json);
    return endereco;
  } else {
    Uri uri = Uri.parse('https://viacep.com.br/ws/$uf/$cidade/$logradouro+$bairro/json/');
    http.Response response = await http.get(uri);
    Map json = jsonDecode(response.body);
    CepModel endereco = CepModel.fromJson(json);
    return endereco;
  }
}