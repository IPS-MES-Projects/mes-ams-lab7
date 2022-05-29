import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_repository/posts_repository.dart';

part 'detail_post_state.dart';

class DetailPostCubit extends Cubit<DetailPostState> {
  DetailPostCubit({required this.postsRepository}) : super(DetailPostInitial());

  final PostsRepository postsRepository;

  Future<void> createPost({
    required Post post,
  }) async {
    emit(PostRequestInProgress());
    try {
      final newPost = await postsRepository.createPost(post: post);
      emit(PostCreateSuccess(post: newPost));
    } on Object catch (e) {
      emit(PostCreateError());
      log(e.toString());
    }
  }

  Future<void> editPost({
    required Post post,
  }) async {
    emit(PostRequestInProgress());
    try {
      await postsRepository.updatePost(post: post);
      emit(PostEditSuccess(post: post));
    } on Object catch (e) {
      emit(PostEditError());
      log(e.toString());
    }
  }
}
