import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/feed/feed_bloc.dart';

class InterestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.red,
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<FeedBloc>(context).add(LikeUser());
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              CircleAvatar(
                  radius: 32,
                  child: IconButton(
                      onPressed: () {
                        BlocProvider.of<FeedBloc>(context).add(UnlikeUser());
                      },
                      icon:
                          Icon(Icons.favorite, color: Colors.white, size: 32))),
            ],
          ),
        ));
  }
}
