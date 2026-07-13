import 'package:apiviacep_frontend/apiviacep_models/apiviacep_models.dart';
import 'package:apiviacep_frontend/apiviacep_repositories/apiviacep_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppViaCEP extends StatelessWidget {
  const AppViaCEP ({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Consulta endereço',
      theme: CupertinoThemeData(brightness: .light),
      home: MyHomePage(title: 'Consulta de Endereço')
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage ({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: CupertinoTextField(
              placeholder: 'DIGITE O CEP',
                onChanged: (value) {
                  if (value == null || value.isEmpty) {
                    SemanticsService.sendAnnouncement(
                      View.of(context),
                      'O campo precisa ser preenchido',
                      Directionality.of(context)
                    );
                  } else if (value.length < 8 || value.length > 8) {
                    SemanticsService.sendAnnouncement(
                      View.of(context),
                      'O CEP digitado é inválido',
                      Directionality.of(context)
                    );
                  }
                },
              controller: cepController,
            )
          ),

        Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: CupertinoButton(
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                botaoMostraEndereco(context);
              }        
            },
            child: const Text('Buscar')
          ),
        )
          
        ],
      ),
    );
  }
}


final cepController = TextEditingController();

void botaoMostraEndereco(BuildContext context) async {
  CepModel endereco = await pegaEndereco(cepController.text);
  if (context.mounted) {
    if (
      endereco.logradouro == '' &&
      endereco.bairro == '' &&
      endereco.complemento == '' &&
      endereco.localidade == '' &&
      endereco.uf == ''
      ) {
        final snackBar = SnackBar(
          content: Text('O CEP não foi encontrado'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Endereço'),
            content: Column(    
              mainAxisSize: MainAxisSize.min,                       
              children: [
                Text('CEP: ${cepController.text}'),                      
                Text('Logradouro: ${endereco.logradouro}'),
                Text('Complemento: ${endereco.complemento}'),
                Text('Bairro: ${endereco.bairro}'),
                Text('Localidade: ${endereco.localidade}'),
                Text('UF: ${endereco.uf}'),
              ],
            )
          );
        }
      );
    } 
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm ({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Consulta de Endereço'),
      ),
      child: Center(
        child: MyCustomForm(),
      ),
    );
  }
}