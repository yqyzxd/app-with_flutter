
import 'package:flutter/cupertino.dart';

/**
 * 隐藏AppBar 并且不会使内容上移到状态栏。
 */
class OffstageAppBar extends PreferredSize{

  BuildContext context;
  OffstageAppBar(this.context);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Offstage(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(MediaQuery.of(context).size.height * 0.07);



}