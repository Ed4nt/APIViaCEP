import 'package:apiviacep_frontend/apiviacep_views/apiviacep_view.dart';
import 'package:flutter/material.dart';

// A classe main é a principal do Dart que indica onde a execução começa
void main () {
  // runApp é um método próprio do Flutter que renderiza o widget passado como argumento e
  // o renderiza fazendo ele ocupar toda a tela
  runApp (const AppViaCEP()); // AppViaCEP é uma classe criada no arquivo 'apiviacep_views.dart'
}