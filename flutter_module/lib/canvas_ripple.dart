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

class _RippleState extends State<Ripple> with TickerProviderStateMixin{
  int count = 4;



  int mRaduis=10;
  @override
  void initState() {
    super.initState();




  }

  void start() {
    for (int i = 0; i < count; i++)
      Future.delayed(Duration(seconds: 500 * i), () {


      });
  }

  List<Widget> _buildRipple() {
    var widgets = [];
    for (int i = 0; i < 4; i++) {
      widgets.add(AnimatedCanvasCircle());
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
  @override
  _AnimatedCanvasCircleState createState() => _AnimatedCanvasCircleState();
}

class _AnimatedCanvasCircleState extends State<AnimatedCanvasCircle> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<int> animation;

  int mRadius;
  int minRaduis=10;
  int maxRaduis=120;

  @override
  void initState() {
    super.initState();

    _animationController=new AnimationController(vsync: this,duration: Duration(seconds: 3));
    animation=new Tween(begin: minRaduis,end: maxRaduis).animate(_animationController);

    animation.addListener(() {
        setState(() {
          mRadius=animation.value;
        });
    });
  }

  void start(){
    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: new CanvasCirclePainter(mRadius),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
