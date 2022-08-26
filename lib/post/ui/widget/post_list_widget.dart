import 'package:flutter/material.dart';
import 'package:infinite_scroll_view/post/bloc/post_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.postState}) : super(key: key);

  final PostState postState;

  @override
  Widget build(BuildContext context) {
    return postState.list.isEmpty
        ? const Center(
            child: Text('No Post Found'),
          )
        : ListView.builder(
            controller: context.read<PostBloc>().scrollController,
            itemCount: postState.list.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: Text('${postState.list[index].id}'),
                      title: Text(postState.list[index].title),
                      trailing: Text('${postState.list[index].userId}'),
                    ),
                  ),
                  Visibility(
                      visible: postState.loadingMore &&
                          index == postState.list.length - 1,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ))
                ],
              );
            }));
  }
}
