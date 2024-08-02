import 'package:dio/dio.dart';
import 'package:people_managment/core/error/exceptions.dart';
import 'package:people_managment/features/post_code/data/models/post_code_data_model.dart';

abstract class RemotePostCodeDataSource {
  Future<PostCodeDataModel> fetchPostCodeData(String postCode);
}

class RemotePostCodeDataSourceImpl extends RemotePostCodeDataSource {
  final Dio dio;
  RemotePostCodeDataSourceImpl({required this.dio});

  @override
  Future<PostCodeDataModel> fetchPostCodeData(String postCode) async {
    try {
      final response = await dio.get(
        "http://kodpocztowy.intami.pl/api/$postCode",
      );
      if (response.statusCode == 200) {
        return PostCodeDataModel.fromApi(response.data[0]);
      } else {
        throw ApiException();
      }
    } on DioException catch (e) {
      throw Exception("Error ${e.response}");
    }
  }
}
