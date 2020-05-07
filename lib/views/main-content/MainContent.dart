import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/notification/notification_bloc.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/views/main-content/FeedView.dart';
import 'package:hireme/views/main-content/NotificationView.dart';
import 'package:hireme/views/main-content/ProfileView.dart';

class MainContent extends StatefulWidget {
  final User user;
  MainContent({this.user});
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int currentPage;
  User user;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: currentPage == 0 ? FeedView(user: user) : currentPage == 1 ? NotificationView() : ProfileView(user: user, me: user)),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColorDark,
                        Theme.of(context).primaryColor
                      ]),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.view_carousel,
                        size: 32,
                        color: currentPage == 0
                            ? Theme.of(context).accentColor
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        size: 32,
                        color: currentPage == 1
                            ? Theme.of(context).accentColor
                            : Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<NotificationBloc>(context).add(LoadNotification(whoUseApp: user));
                        setState(() {
                          currentPage = 1;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        size: 32,
                        color: currentPage == 2
                            ? Theme.of(context).accentColor
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 2;
                        });
                      },
                    ),
                  ],
                ))));
  }
}
