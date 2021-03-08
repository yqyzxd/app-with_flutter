import 'package:flutter/material.dart';
import 'package:flutter_module/articles_view_model.dart';
import 'package:flutter_module/bean/article.dart';
import 'package:flutter_module/request/articles_request.dart';
import 'package:flutter_module/response/articles_response.dart';
import 'package:flutter_module/wind/adapters.dart';
import 'package:flutter_module/wind/pager/page_request.dart';

import 'wind/base_pager_widget.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState
    extends BasePagerState<ArticlesViewModel, ArticlesResponse> {
  @override
  PageRequest buildRequest(bool firstPage) {
    ArticlesRequest request = new ArticlesRequest();
    request.firstPage = firstPage;
    request.page = 0;
    request.size = 10;
    return request;
  }

  @override
  BaseDelegateAdapter createAdapter() {
    return ArticleAdapter();
  }
}

class ArticleAdapter extends BaseDelegateAdapter {
  @override
  void addDelegate() {
    manager.addDelegate(new ArticleDelegate());
  }
}

class ArticleDelegate extends AdapteDelegate<Article> {
  @override
  bool isForViewType(DisplayItem item, int position) {
    return item is Article;
  }

  @override
  Widget onBuildWidget(Article item, int position) {
    return Text(item.title);
  }
}
