import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/feed/feed_bloc.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/main-content/ProfileView.dart';
import 'package:swipe_stack/swipe_stack.dart';

class SuggestionCard extends StatelessWidget {
  final List<User> usersSuggestion;
  final User me;
  SuggestionCard({this.usersSuggestion, this.me});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 6,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: InkWell(
            child: SwipeStack(
              children: usersSuggestion
                  .map((user) {
                    return SwiperItem(
                        builder: (SwiperPosition position, double progress) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileView(
                                    user: user,
                                    me: me,
                                  )));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(user.avatarURL,
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    });
                  })
                  .toList()
                  .reversed
                  .toList(),
              visibleCount: 3,
              stackFrom: StackFrom.Top,
              translationInterval: 6,
              scaleInterval: 0.03,
              onEnd: () => print('end'),
              onSwipe: (int index, SwiperPosition position) =>
                  giveInterest(context, position),
              onRewind: (int index, SwiperPosition position) => print(position),
            ),
          )),
    );
  }

  void giveInterest(BuildContext context, SwiperPosition position) {
    if (position == SwiperPosition.Left) {
      BlocProvider.of<FeedBloc>(context).add(UnlikeUser());
    } else if (position == SwiperPosition.Right) {
      BlocProvider.of<FeedBloc>(context).add(LikeUser(sender: me));
    }
  }
}
