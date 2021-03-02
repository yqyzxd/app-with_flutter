import 'package:flutter/material.dart';
import 'package:flutter_module/adapters.dart';
import 'package:flutter_module/http/Dios.dart';
class MsgNotificationSettingWidget extends StatefulWidget {
  @override
  _MsgNotificationSettingWidgetState createState() => _MsgNotificationSettingWidgetState();
}

class _MsgNotificationSettingWidgetState extends State<MsgNotificationSettingWidget> {

  final items=<DisplayItem>[];
  final adapter=SettingAdapter();

  _MsgNotificationSettingWidgetState(){

    items.add(SettingItem("动态评论通知", true, "dynamic_reply", true));
    items.add(SettingItem("动态点赞通知", true, "dynamic_star",  false));
    items.add(SettingItem("同城用户上麦通知", true, "live_city_up", true));
    items.add(SettingItem("心动用户上麦通知", true, "live_like_up", false));

    adapter.replace(items);
  }

  @override
  void initState() {
    super.initState();
    Dios.instance.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _listView(),
    );
  }


  Widget _listView(){
   return  ListView.builder(
        itemBuilder: (context,i){
          if (i.isOdd) return Divider(height:0.0);

          final index = i ~/ 2;
          if (index >= items.length) {
            //加载更多
          }else{
            return _buildRow(items[index],index);
          }
        });
  }
  Widget _buildRow(DisplayItem displayItem,int position){
    return adapter.onBuildWidget(position);
  }



}

class SettingAdapter extends BaseDelegateAdapter{

  @override
  void addDelegate() {
      manager.addDelegate(SettingItemDelegate());
  }



}

class SettingItemDelegate extends AdapteDelegate<DisplayItem>{
  @override
  bool isForViewType(DisplayItem item, int position) {
   return item is SettingItem;
  }

  @override
  Widget onBuildWidget(DisplayItem item, int position) {

    return SettingItemWidget(item as SettingItem);
  }

}
class SettingItemWidget extends StatelessWidget{

  final SettingItem item;

  SettingItemWidget(this.item);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
              item._title,
            style: TextStyle(color:Colors.black,fontSize: 16),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child:Image(
            image: AssetImage(item._open?"icons/icon_cb_selected.png":"icons/icon_cb_normal.png"),
            width: 50,
            height: 25,
          )
        )
      ],
    );
  }

}
class SettingItem implements DisplayItem{
  String _title;
  bool _open;
  String _id;
  bool showLine;

  SettingItem(this._title, this._open, this._id, this.showLine);


}
