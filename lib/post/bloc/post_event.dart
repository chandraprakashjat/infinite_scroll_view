part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> props() => [];
}

class GetPost extends PostEvent {}

class LoadMore extends PostEvent {}
