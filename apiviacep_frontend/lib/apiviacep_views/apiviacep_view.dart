import 'package:apiviacep_frontend/apiviacep_models/apiviacep_models.dart';
import 'package:apiviacep_frontend/apiviacep_repositories/apiviacep_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Esse é o widget raiz que é chamado pelo metodo runApp no main.dart, ele define as opções gerais
// do app como: título, tema e página inicial do app
// Estendemos a classe StatelessWidget, ela indica que o widget não tem sua estrutura visual alterada mantendo-se estática
class AppViaCEP extends StatelessWidget { 
  const AppViaCEP ({super.key}); 

  // Aqui o método build é sobreescrito para retornar as características do app
  // Toda classe que herda um Widget precisa implementar o método widget
  // ele descreve a parte da interface representada por este widget
  @override
  Widget build(BuildContext context) {
  // A classe BuildContext indica a localização do widget na arvore de widgets
    return CupertinoApp( // Foi escolhido o CupertinoApp para ter uma estética similar ao iOS
      title: 'Consulta endereço',
      theme: CupertinoThemeData(brightness: .light),
      home: MyHomePage(title: 'Consulta de Endereço',) // O argumento title vem da classe MyHomePage
    );
  }
}

// A classe MyHomePage estende o statefull widget indicando que sua estrutura visual pode ser alterada
class MyHomePage extends StatefulWidget {
  const MyHomePage ({super.key, required this.title});

  final String title;

  // Sobreescreve o método createState da classe StatefullWidget
  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final cepController = TextEditingController();

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

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
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Erro'),
            content: const Text('O CEP não foi encontrado'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok')
              )
            ],
          )
        );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Endereço'),
          content: Column(
            children: [
              Text('CEP: ${cepController.text}'),                      
              Text('Logradouro: ${endereco.logradouro}'),
              Text('Complemento: ${endereco.complemento}'),
              Text('Bairro: ${endereco.bairro}'),
              Text('Localidade: ${endereco.localidade}'),
              Text('UF: ${endereco.uf}'),
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok')
            )
          ],
        )
      );
    } 
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SafeArea( 
            child: Column(
              children: [
                CupertinoTextFormFieldRow(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  placeholder: 'CEP',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'O campo precisa ser preenchido';
                    } else if (value.length != 8) {
                      return 'Este CEP é inválido';
                    }
                  },
                  controller: cepController,
                ),
                CupertinoButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      botaoMostraEndereco(context);
                    }
                  },
                  child: const Text('Buscar'),
                )
              ]
            ),
          ),
        ],
      ),
    );
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