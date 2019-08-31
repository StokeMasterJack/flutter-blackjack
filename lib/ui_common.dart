import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;

import 'blackjack.dart';

typedef Widget ViewBuilder(BjModel model);

abstract class IBjModel {
  Game get g;

  void onDeal();

  void onHit();

  void onStay();
}

class BjModel {
  final Game g;
  final VoidCallback onDeal;
  final VoidCallback onHit;
  final VoidCallback onStay;

  BjModel(this.g, this.onDeal, this.onHit, this.onStay);
}

bool notNull(Object o) => o != null;

class ButtonsView extends StatelessWidget {
  final bool isGameOver;
  final VoidCallback onDeal;
  final VoidCallback onHit;
  final VoidCallback onStay;

  ButtonsView({this.isGameOver, this.onDeal, this.onHit, this.onStay});

  @override
  Widget build(BuildContext context) {
    assert(context != null);

    Color color = Theme.of(context).canvasColor;
    const sep = 15.0;

    return Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            mkButton(
              context: context,
              title: "Deal",
              onPressed: isGameOver ? onDeal : null,
            ),
            SizedBox(width: sep),
            mkButton(
              context: context,
              title: "Hit",
              onPressed: !isGameOver ? onHit : null,
            ),
            SizedBox(width: sep),
            mkButton(
              context: context,
              title: "Stay",
              onPressed: !isGameOver ? onStay : null,
            ),
          ],
        ));
  }
}

class MsgView extends StatelessWidget {
  final String msg;

  MsgView(this.msg);

  @override
  Widget build(BuildContext context) {
    assert(context != null);

    var theme = Theme.of(context);

    TextStyle textStyle = theme.textTheme.title.copyWith(
      color: theme.errorColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
    );

    String msg = this.msg.toUpperCase();

    return Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
//      color: theme.secondaryHeaderColor,
        child: Text(msg, style: textStyle));
  }
}

Widget mkButton(
    {@required BuildContext context,
    @required String title,
    VoidCallback onPressed /* null to disbale button */
    }) {
  ThemeData theme = Theme.of(context);
  TargetPlatform platform = theme.platform;

  bool isIOS = platform == TargetPlatform.iOS;

  Widget mkBtnMat() {
    return RaisedButton(
        key: Key(title),
        child: Text(title.toUpperCase()),
        onPressed: onPressed);
  }

  Widget mkBtnCup() {
    return CupertinoButton(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Text(title.toUpperCase()),
        onPressed: onPressed);
  }

  if (isIOS) {
    return mkBtnCup();
  } else {
    return mkBtnMat();
  }
}
