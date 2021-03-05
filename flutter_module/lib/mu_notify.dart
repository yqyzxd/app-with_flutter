import 'package:flutter/material.dart';
import 'package:flutter_module/adapters.dart';
import 'package:flutter_module/http/dios.dart';
import 'package:flutter_module/title_bar.dart';

class MsgNotificationSettingWidget extends StatefulWidget {
  @override
  _MsgNotificationSettingWidgetState createState() =>
      _MsgNotificationSettingWidgetState();
}

class _MsgNotificationSettingWidgetState
    extends State<MsgNotificationSettingWidget> {
  final items = <DisplayItem>[];
  final adapter = SettingAdapter();

  _MsgNotificationSettingWidgetState() {
    items.add(SettingGroup("动态通知"));
    items.add(SettingItem("动态评论通知", true, "dynamic_reply", true));
    items.add(SettingItem("动态点赞通知", true, "dynamic_star", false));
    items.add(SettingGroup("直播通知"));
    items.add(SettingItem("同城用户上麦通知", true, "live_city_up", true));
    items.add(SettingItem("心动用户上麦通知", true, "live_like_up", false));
    items.add(LoadingMoreItem());
    adapter.replace(items);
  }



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _listView(),
    );*/
    return Column(
      children: [
        TitlerBar('设置'),
        Expanded(child:  _listView())

      ],
    );
    
    return TitlerBar('设置');
  }

  Widget _listView() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return Divider(height: 0.0);

      final index = i ~/ 2;
      if (index >= items.length) {
        //加载更多
      } else {
        return _buildRow(items[index], index);
      }
    });
  }

  Widget _buildRow(DisplayItem displayItem, int position) {
    return adapter.onBuildWidget(position);
  }
}

class SettingAdapter extends BaseDelegateAdapter {
  @override
  void addDelegate() {
    manager
        .addDelegate(SettingItemDelegate())
        .addDelegate(SettingGroupDelegate())
        .addDelegate(LoadingMoreDelegate());
  }
}

class SettingGroupDelegate extends AdapteDelegate<DisplayItem> {
  @override
  bool isForViewType(DisplayItem item, int position) {
    return item is SettingGroup;
  }

  @override
  Widget onBuildWidget(DisplayItem item, int position) {
    return SettingGroupWidget(item as SettingGroup);
  }
}

class SettingGroupWidget extends StatelessWidget {
  final SettingGroup item;

  SettingGroupWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Image.asset(
            'icons/bg_setting_group.png',
            width: 107,
            height: 26,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
            child: Text(
              item.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ) ;
  }
}

class SettingItemDelegate extends AdapteDelegate<DisplayItem> {
  @override
  bool isForViewType(DisplayItem item, int position) {
    return item is SettingItem;
  }

  @override
  Widget onBuildWidget(DisplayItem item, int position) {
    return SettingItemWidget(item as SettingItem);
  }
}

class SettingItemWidget extends StatelessWidget {
  final SettingItem item;

  SettingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      height: 50,
      alignment: Alignment.center,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item._title,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Image(
                image: AssetImage(item._open
                    ? "icons/icon_cb_selected.png"
                    : "icons/icon_cb_normal.png"),
                width: 50,
                height: 28,
              ))
        ],
      ),
    );
  }
}

class SettingItem implements DisplayItem {
  String _title;
  bool _open;
  String _id;
  bool showLine;

  SettingItem(this._title, this._open, this._id, this.showLine);
}

class SettingGroup implements DisplayItem {
  String title;

  SettingGroup(this.title);
}
