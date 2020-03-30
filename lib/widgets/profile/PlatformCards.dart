import 'package:flutter/material.dart';


class PlatformCards extends StatelessWidget {
  final List<String> platforms;
  PlatformCards({this.platforms});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: platforms.map((platform) => renderCard(context, platform)).toList()
      )),
    );
  }

  Container renderCard(BuildContext context, String platform) {
    Icon icon;
    switch(platform) {
      case 'Web':
        icon = renderIconPlatform(Icons.language);
        break;
      case 'Mobile':
        icon = renderIconPlatform(Icons.phone_iphone);
        break;
      case 'Bureau':
        icon = renderIconPlatform(Icons.desktop_windows);
        break;
      default:
        break;
    }
    return Container(
      width: 64,
      height: 64,
      child: Card(
        color: Theme.of(context).primaryColorDark,
        child: Center(child: icon)
      ),
    );
  }

  Icon renderIconPlatform(IconData icon) => Icon(icon, color: Colors.white);
}
