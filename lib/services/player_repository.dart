import 'package:football_teams/models/api_models.dart';
import 'package:football_teams/search_configuration.dart';
import 'package:football_teams/services/player_api_provider.dart';

class PlayerRepository {
  PlayerApiProvider _playerApiProvider = PlayerApiProvider();

  Future<List<Players>> fetchPlayersByCountry(String countryId) =>
      _playerApiProvider.fetchPlayersByCountry(countryId);

  Future<List<Players>> fetchPlayersByName(String name) =>
      _playerApiProvider.fetchPlayersByName(name);

  Future<List<Players>> fetchPlayerSearchConfiguration(SearchConfiguration searchConfiguration) =>
      _playerApiProvider.fetchPlayersSearchConfiguration(searchConfiguration);
}
