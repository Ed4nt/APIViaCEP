class CepModel {
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;

  CepModel({
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
  });

  factory CepModel.fromJson(Map json) {
    return CepModel(
      logradouro: json['logradouro'] ?? '',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? '',
      localidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
    ); 
  }
}