import 'package:football_teams/models/api_models.dart';
import 'package:football_teams/search_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlayerApiProvider {
  String baseUrl = "https://www.easports.com/fifa/ultimate-team/api/fut/item?";
  final int successCode = 200;

  List<Players> parseResponse(http.Response response) {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == successCode) {
      return ApiResult.fromJson(responseString).items;
    } else {
      throw Exception('Faild to load players');
    }
  }

  Future<List<Players>> fetchPlayersByCountry(String countryId) async {
    final response = await http.get("$baseUrl+countryId=$countryId");

    return parseResponse(response);
  }

  Future<List<Players>> fetchPlayersByName(String name) async {
    final response = await http.get("$baseUrl+name=$name");

    return parseResponse(response);
  }

  Future<List<Players>> fetchPlayersSearchConfiguration(SearchConfiguration searchConfiguration) async {

    String queryParameters = "";

    if (searchConfiguration.selectedPositions.isNotEmpty) {
      queryParameters += "position=" + searchConfiguration.selectedPositions.join(",");
      print("POSITIONS -- " + queryParameters);
    }

    if (searchConfiguration.selectedLeagues.isNotEmpty) {
      if (queryParameters.isNotEmpty) {
        queryParameters += "&";
      }

      queryParameters += "club=" + searchConfiguration.selectedLeagues.values.join(",");
      print("LEAGUES -- " + queryParameters);
    }

    if (searchConfiguration.selectedNations.isNotEmpty) {
      if (queryParameters.isNotEmpty) {
        queryParameters += "&";
      }

      queryParameters += "country=" + searchConfiguration.selectedNations.values.join(",");
      print("NATIONS -- " + queryParameters);
    }

    final response = await http.get(baseUrl+queryParameters);

    return parseResponse(response);
  }
}