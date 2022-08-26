part of 'post_bloc.dart';

enum PostEnum { initial, loadPost, success, failed }

class PostState extends Equatable {
  const PostState(
      {this.list = const <PostItem>[],
      this.postEnum = PostEnum.initial,
      this.loadingMore = false,
      this.failMessage = ''});

  final List<PostItem> list;
  final PostEnum postEnum;
  final bool loadingMore;
  final String failMessage;

  PostState copyWith(
      {List<PostItem>? list,
      PostEnum? postEnum,
      bool? loadingMore,
      String? failMessage}) {
    return PostState(
        list: list ?? this.list,
        postEnum: postEnum ?? this.postEnum,
        loadingMore: loadingMore ?? this.loadingMore,
        failMessage: failMessage ?? this.failMessage);
  }

  @override
  List<Object?> props() => [list, postEnum, loadingMore, failMessage];
}
