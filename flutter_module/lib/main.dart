import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_module/flutter_initializer.dart';
import 'package:flutter_module/http/base_response.dart';
import 'package:flutter_module/http/dios.dart';
import 'package:flutter_module/mu_notify.dart';
import 'package:flutter_module/request/banner_request.dart';

import 'response/banner_response.dart';
import 'widget_loading.dart';
import 'user_detail_page.dart';


void main() => runApp(UserDetailPage());





class MyApp extends StatelessWidget {

  MyApp(){
    FlutterInitializer.init();
    testHttp();




  }

  void testHttp(){
    final bannerRequest=BannerRequest();
    Dios.getInstance().get("/banner/json", bannerRequest.toJson(),(responseMap){
      final response=BannerResponse.fromJson(responseMap);
      response.data.forEach((element) {
        print(element.desc);
      });
    },(e){
      print("onError"+e.msg);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Flutter",
      theme: ThemeData(primaryColor: Colors.white),
      home:LoadingWidget(
          content: MsgNotificationSettingWidget(),
        state: LoadingWidget.CONTENT_STATE,
      ),//RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return new ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
