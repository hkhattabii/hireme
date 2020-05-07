import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireme/blocs/feed/feed_bloc.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/main-content/InterestButton.dart';
import 'package:hireme/views/main-content/SuggestionCard.dart';
import 'package:hireme/views/main-content/SuggestionHeader.dart';

class FeedView extends StatelessWidget {
  final User user;
  FeedView({this.user});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
        builder: (BuildContext context, FeedState feedState) {
      if (feedState is FeedStateUninitialized)
        return Center(child: CircularProgressIndicator());
      else if (feedState is FeedStateInitialized) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: <Widget>[
              SuggestionHeader(
                userSuggesting: feedState.userSuggesting,
              ),
              Flexible(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    SuggestionCard(
                        usersSuggestion: feedState.userSuggestions, user: user),
                    InterestButton(user: user)
                  ]),
                ),
              ),
            ],
          ),
        );
      }
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Plus d'utilisateur à suggérer"),
            RaisedButton(
              child: Text(
                'Charger plus',
                style: GoogleFonts.roboto(color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                BlocProvider.of<FeedBloc>(context)
                    .add(LoadUser(whoUseApp: user));
              },
            )
          ],
        )),
      );
    });
  }
}
