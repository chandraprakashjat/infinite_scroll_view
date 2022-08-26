import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/model.dart';
part 'post_state.dart';
part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  ScrollController? scrollController;
  PostBloc() : super(const PostState()) {
    on<GetPost>(_mapGetPostEvent);
    on<LoadMore>(_mapLoadMoreEvent);

    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController?.position.maxScrollExtent ==
            scrollController?.offset) {
          if (!state.loadingMore) {
            add(LoadMore());
          }
        }
      });
  }

  FutureOr<void> _mapGetPostEvent(
      GetPost event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(postEnum: PostEnum.loadPost));
      var list = await getPost(0, 20);

      emit(state.copyWith(list: list, postEnum: PostEnum.success));
    } catch (error) {
      emit(state.copyWith(
          postEnum: PostEnum.failed, failMessage: error.toString()));
    }
  }

  FutureOr<void> _mapLoadMoreEvent(
      LoadMore event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(loadingMore: true));
      List<PostItem> list = await getPost(state.list.length, 20);
      await Future.delayed(const Duration(seconds: 2));

      if (list.isEmpty) {
        emit(state.copyWith(
            loadingMore: false,
            postEnum: PostEnum.failed,
            failMessage: 'No more Post found'));
      } else {
        emit(state.copyWith(
            list: [...state.list, ...list],
            loadingMore: false,
            postEnum: PostEnum.success));
      }
    } catch (error) {
      emit(state.copyWith(
          postEnum: PostEnum.failed,
          loadingMore: false,
          failMessage: error.toString()));
    }
  }

  Future<List<PostItem>> getPost(int start, int limit) async {
    try {
      var params = <String, String>{
        '_start': start.toString(),
        '_limit': limit.toString()
      };
      Uri uri = Uri.https('jsonplaceholder.typicode.com', 'posts', params);

      http.Response response = await http.get(uri);

      print(response.body);

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => PostItem.fromJson(e))
            .toList();
      } else {
        throw response.body.toString();
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
