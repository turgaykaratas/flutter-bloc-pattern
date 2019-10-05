import 'package:bloc/bloc.dart';
import 'package:football_teams/bloc/player_listing_events.dart';
import 'package:football_teams/bloc/player_listing_states.dart';
import 'package:football_teams/models/api_models.dart';
import 'package:football_teams/services/player_repository.dart';

class PlayerListingBloc extends Bloc<PlayerListingEvent, PlayerListingState> {
  final PlayerRepository playerRepository;

  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);

  @override
  void onTransition(
      Transition<PlayerListingEvent, PlayerListingState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  PlayerListingState get initialState => PlayerUninitializedState();

  @override
  Stream<PlayerListingState> mapEventToState(PlayerListingEvent event) async* {
    yield PlayerFetchingState();
    try {
      List<Players> players;
      if (event is CountrySelectedEvent) {
        players = await playerRepository
            .fetchPlayersByCountry(event.nationModel.countryId);
      } else if (event is SearchTextChangedEvent) {
        players = await playerRepository.fetchPlayersByName(event.searchTerm);
      }else if(event is AdvanceSearchChangeEvent){
        players = await playerRepository.fetchPlayerSearchConfiguration(event.searchConfiguration);
      }
      if (players.length == 0) {
        yield PlayerEmptyState();
      } else {
        yield PlayerFetchedState(players: players);
      }
    } catch (e) {
      yield PlayerErrorState();
    }
  }
}
