import 'package:flutter/material.dart';

class CanvasCirclePainter extends CustomPainter {
  int minRadius;
  int maxRadius;
  Paint mPaint;
  int mRadius;

  bool start;

  CanvasCirclePainter(this.mRadius) {
    mPaint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = 1;
    mPaint.color = (Colors.white);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(offset, mRadius.roundToDouble(), mPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Ripple extends StatefulWidget {
  @override
  _RippleState createState() => _RippleState();
}

class _RippleState extends State<Ripple> with TickerProviderStateMixin {
  int count = 4;

  int mRaduis = 10;

  var childStates= <AnimatedCanvasCircle>[];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      print("_RippleState delayed");
      start();
    });

  }

  void start() {

    for (int i = 0; i < count; i++)
      Future.delayed(Duration(milliseconds: 500 * i), () {
        childStates[i].state.start();
      });
      //获取state
     /* context.visitChildElements((element) {
        print(element.widget.runtimeType);
        if (element.widget is AnimatedCanvasCircle) {
          var circleWidget = element.widget as AnimatedCanvasCircle;
          Future.delayed(Duration(seconds: 500 * i), () {
            print("circleWidget.state.start()");
            circleWidget.state.start();
          });
        }
      });*/
  }



  List<Widget> _buildRipple() {
    childStates.clear();
    var widgets = <Widget>[];
    for (int i = 0; i < 4; i++) {
     var circle= AnimatedCanvasCircle();
     childStates.add(circle);
      widgets.add(circle);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildRipple(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AnimatedCanvasCircle extends StatefulWidget {
  _AnimatedCanvasCircleState state;

  AnimatedCanvasCircle({Key key}) : super(key: key);

  @override
  _AnimatedCanvasCircleState createState() {
    state = _AnimatedCanvasCircleState();
    return state;
  }
}

class _AnimatedCanvasCircleState extends State<AnimatedCanvasCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<int> animation;

  int mRadius = 60;
  int minRaduis = 10;
  int maxRaduis = 120;

  @override
  void initState() {
    super.initState();
    mRadius=minRaduis;
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = new IntTween(begin: minRaduis, end: maxRaduis)
        .animate(_animationController);

    animation.addListener(() {
      setState(() {
        mRadius = animation.value;
        print("mRadius: $mRadius");
      });
    });



  }

  void start() {

    _animationController.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(600, 600),
      painter: new CanvasCirclePainter(mRadius),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
