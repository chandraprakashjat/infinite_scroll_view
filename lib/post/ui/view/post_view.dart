import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_view/post/bloc/post_bloc.dart';
import 'package:infinite_scroll_view/post/post.dart';

class PostViewWidget extends StatelessWidget {
  const PostViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(listener: (context, state) {
      if (state.postEnum == PostEnum.failed) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.failMessage)));
      }
    }, builder: ((context, state) {
      switch (state.postEnum) {
        case PostEnum.initial:
          return const Center(
            child: Text('No, Post found'),
          );
        case PostEnum.loadPost:
          return const Center(
            child: CircularProgressIndicator(),
          );

        default:
          {
            return PostListWidget(
              postState: state,
            );
          }
      }
    }));
  }
}
