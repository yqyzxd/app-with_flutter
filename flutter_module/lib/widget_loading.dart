import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  static const int LOADING_STATE = 0;
  static const int CONTENT_STATE = 1;
  static const int ERROR_STATE = 2;
  static const int EMPTY_STATE = 3;
  Widget content;
  Widget loading;
  Widget error;
  Widget empty;
  int state = LOADING_STATE;

  LoadingWidget(
      {Key key,
      this.content,
      this.state = LOADING_STATE,
      this.loading,
      this.error,
      this.empty})
      : assert(content != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (state) {
      case LoadingWidget.LOADING_STATE:
        child = loading == null ? CircularProgressIndicator() : loading;
        break;
      case LoadingWidget.CONTENT_STATE:
        child = content;
        break;
      case LoadingWidget.ERROR_STATE:
        child = error == null ? DefaultLoadingErrorWidget() : error;
        break;
      case LoadingWidget.EMPTY_STATE:
        child = empty == null ? DefaultLoadingEmptyWidget() : empty;
        break;
    }
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: child,
    );
  }
}

class DefaultLoadingEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('icons/base_icon_empty.png'),
        Container(
          margin: EdgeInsets.only(top: 36),
          child: Text(
            '空空如也',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
        )
      ],
    );
  }
}

class DefaultLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

class DefaultLoadingErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('icons/base_icon_error.png'),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            '网络错误或无连接',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Container(
            width: 200,
            height: 50,
            margin: EdgeInsets.only(top: 100),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF999999), width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                '重新加载',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
            ))
      ],
    );
  }
}
