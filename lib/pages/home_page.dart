import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_teams/bloc/player_listing_bloc.dart';
import 'package:football_teams/bloc/player_listing_events.dart';
import 'package:football_teams/pages/advanced_search_page.dart';
import 'package:football_teams/pages/player_listing.dart';
import 'package:football_teams/search_configuration.dart';
import 'package:football_teams/services/player_repository.dart';
import 'package:football_teams/themes/themes.dart';
import 'package:football_teams/widgets/horizontal_bar.dart';
import 'package:football_teams/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  final PlayerRepository playerRepository;

  HomePage({this.playerRepository});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlayerListingBloc _playerListingBloc;
  SearchConfiguration _searchConfiguration = SearchConfiguration();

  @override
  void initState() {
    super.initState();
    _playerListingBloc =
        PlayerListingBloc(playerRepository: widget.playerRepository);
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerListingBloc>(
      builder: (context) => _playerListingBloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Advanced Search"),
          icon: Icon(Icons.filter_list),
          onPressed: () async {
            final resultMap = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdvancedSearchPage(
                          searchConfiguration: _searchConfiguration,
                        )));
                        
            _searchConfiguration = resultMap["search_configuration"];
            
            _playerListingBloc.dispatch(AdvanceSearchChangeEvent(
                searchConfiguration: _searchConfiguration));
          },
        ),
        appBar: AppBar(
          title: Text(
            'Football Players',
            style: appBarTextStyle,
            textAlign: TextAlign.justify,
          ),
        ),
        body: Column(
          children: <Widget>[
            HorizontalBar(),
            SizedBox(height: 10.0),
            SearchBar(),
            SizedBox(height: 10.0),
            PlayerListing()
          ],
        ),
      ),
    );
  }
}
