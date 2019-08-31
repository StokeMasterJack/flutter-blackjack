import 'package:flutter/material.dart' hide Card;
import 'blackjack.dart';
import 'ui_common.dart';

const title = 'Flutter Blackjack';

class BjController extends StatefulWidget {
  final ViewBuilder viewBuilder;

  BjController({Key key, this.viewBuilder}): super(key: key);

  @override
  createState() => BjControllerState();
}

class BjControllerState extends State<BjController> {
  Game g;

  void onHit() {
    setState(() {
      g.hit();
    });
  }

  void onStay() {
    setState(() {
      g.stay();
    });
  }

  void onDeal() {
    setState(() {
      g.deal();
    });
  }

  @override
  void initState() {
    super.initState();
    g = Game();
  }

  @override
  Widget build(BuildContext ctx) {
    BjModel model = BjModel(g, onDeal, onHit, onStay);
    return widget.viewBuilder(model);
  }
}
