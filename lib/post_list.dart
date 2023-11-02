import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'api_service.dart';
import 'post.dart';
import 'post_detail.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ApiService.fetchPosts(pageKey);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Post>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
        itemBuilder: (context, item, index) => Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title:
                Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.body),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetail(postId: item.id),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
