import 'package:football_teams/models/nation.dart';
import 'package:football_teams/search_configuration.dart';
import 'package:meta/meta.dart';

abstract class PlayerListingEvent {}

class CountrySelectedEvent extends PlayerListingEvent {
  final NationModel nationModel;

  CountrySelectedEvent({@required this.nationModel})
      : assert(nationModel != null);
}

class SearchTextChangedEvent extends PlayerListingEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);
}

class AdvanceSearchChangeEvent extends PlayerListingEvent {
  final SearchConfiguration searchConfiguration;

  AdvanceSearchChangeEvent({@required this.searchConfiguration})
      : assert(searchConfiguration != null);
}
