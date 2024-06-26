import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import 'package:lamie_middle_east/utils/app_exceptions.dart';

typedef EitherResponse = Future<Either<AppExceptions, dynamic>>;

class ApiService {
  static Map<String, String> header = {"Content-Type": "application/json"};

  static EitherResponse postApi(var data, String url, [String? token]) async {
    final uri = Uri.parse(url);
    final body = jsonEncode(data);
    try {
      final response = await http.post(uri, body: body, headers: header);
      final responseBody = getResponse(response);
      return Right(responseBody);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static EitherResponse getApi(String url, [String? token]) async {
    if (token != null) {
      header["Authorization"] = "Bearer $token";
    }
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: header);
      final body = getResponse(response);
      return Right(body);
    } on SocketException {
      return Left(InterntExceptions());
    } on http.ClientException {
      return Left(BadRequestExceptions());
    } catch (e) {
      return Left(RequestTimeOutExceptions());
    }
  }

  static getResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw BadRequestExceptions();
    } else if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw NoDataFound();
    } else {
      throw BadRequestExceptions();
    }
  }
}
