import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_error.dart';
import 'package:xlo/repositories/api_response.dart';

Future<ApiResponse> getAddressFromAPI(String postalCode) async {

  postalCode = postalCode
      .replaceAll('.', '')
      .replaceAll('-', '');

  final String endpoint = 'https://viacep.com.br/ws/$postalCode/json';

  try {
    final Response response = await Dio().get(endpoint);
    if (response.data.containsKey('erro') && response.data['erro']) {
      return ApiResponse.error(
        error: ApiError(
          code: -2,
          message: 'Cep inválido',
        )
      );
    }
    final Address address = Address.fromMap(response.data);

    return ApiResponse.success(result: address);

  } on DioError catch(_) {
    return ApiResponse.error(
      error: ApiError(
        code: -1,
        message: 'Falha ao conectar com ViaCep',
      )
    );
  }
}