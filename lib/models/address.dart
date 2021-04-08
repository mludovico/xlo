class Address {

  Address({
    this.place,
    this.district,
    this.city,
    this.postalCode,
    this.uf,
  });

  String place;
  String district;
  String city;
  String postalCode;
  String uf;

  factory Address.fromMap(Map map) => Address(
    place: map['logradouro'] ?? '',
    district: map['bairro'] ?? '',
    city: map['localidade'] ?? '',
    postalCode: map['cep'] ?? '',
    uf: map['uf'] ?? '',
  );

  Map toMap() => {
    'logradouro': place ?? '',
    'bairro': district ?? '',
    'locallidade': city ?? '',
    'cep': postalCode ?? '',
    'uf': uf ?? '',
  };

  @override
  String toString() => '$place, $district, $city, $uf, $postalCode';
}