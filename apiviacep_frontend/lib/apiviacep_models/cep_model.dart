class CepModel {
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? erro;

  CepModel({
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.erro
  });

  factory CepModel.fromJson(Map json) {
    return CepModel(
      logradouro: json['logradouro'] ?? '',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? '',
      localidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
      erro: json['erro'] ?? 'false'
    ); 
  }
}