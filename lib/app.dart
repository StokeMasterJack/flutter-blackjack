import 'package:blackjack/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Card;

import 'controller.dart';
import 'ui_common.dart';
import 'ui_graphic.dart';
import 'ui_text.dart';

class App extends StatefulWidget {
  @override
  State createState() => AppState();
}

class AppState extends State<App> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
//    TargetPlatform platform = TargetPlatform.iOS;
//    TargetPlatform platform = TargetPlatform.android;
    TargetPlatform platform = defaultTargetPlatform;

    ThemeData baseTheme = light ? themeLight : themeDark;
    ThemeData theme = baseTheme.copyWith(platform: platform);
    var title = "Flutter Blackjack";
    return MaterialApp(
        theme: theme,
        title: title,
        home: BjPage(body: HomeBody(), title: title));
  }
}

class BjPage extends StatelessWidget {
  final Widget body;
  final String title;

  BjPage({this.body, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.sentiment_very_satisfied),
              onPressed: () {
              },
            )
          ],
        ),
        body: body);
  }
}

class HomeBody extends StatelessWidget {
  void nav(BuildContext ctx, Widget page) {
    Route<void> rt = MaterialPageRoute(builder: (_) => page);
    Navigator.push(ctx, rt);
  }

  Widget mkAppButton(BuildContext ctx, String suffix, ViewBuilder b) {
    String windowTitle = "Blackjack - $suffix";
    String buttonCaption = "Play Game - $suffix";

    void onPressed() {
      Widget controller = BjController(viewBuilder: b);
      Widget page = BjPage(body: controller, title: windowTitle);
      nav(ctx, page);
    }

    return Padding(
        padding: EdgeInsets.all(2.0),
        child:
            mkButton(context: ctx, title: buttonCaption, onPressed: onPressed));
  }

  Widget mkButtonBar(BuildContext ctx) {
    return Container(
      alignment: Alignment.center,
//      color: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          mkAppButton(ctx, "UI 1", GameView.mk),
          mkAppButton(ctx, "UI 2", GGameView.mk),
//          mkAppButton(ctx, "UI 3", GGameView.mk),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      alignment: Alignment.center,
//      color: Colors.yellow,
      padding: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset("images/blackjack-1.jpg"),
//          SizedBox(height: 50.0),
          Expanded(child: mkButtonBar(ctx))
        ],
      ),
    );
  }
}
