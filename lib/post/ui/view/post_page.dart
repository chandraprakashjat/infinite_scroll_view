import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_view/post/bloc/post_bloc.dart';
import 'package:infinite_scroll_view/post/ui/view/view.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite List'),
      ),
      body: BlocProvider(
        create: (_) => PostBloc()..add(GetPost()),
        child: const PostViewWidget(),
      ),
    );
  }
}
