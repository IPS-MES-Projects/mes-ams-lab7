import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_repository/posts_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.postsRepository}) : super(const HomeInitial());

  final PostsRepository postsRepository;

  Future<void> loadPosts() async {
    emit(PostsLoadInProgress(posts: state.posts));
    try {
      final posts = await postsRepository.getPosts();
      emit(PostsLoadSuccess(posts: posts));
    } on Object catch (e) {
      emit(PostsLoadError(posts: state.posts));
      log(e.toString());
    }
  }

  Future<void> createPost({
    required Post newPost,
  }) async {
    // Forces load of the posts for api emulation purposes
    // Otherwise newly created posts, after first one, would not show due to the
    //id being always 101 for newly created posts
    await loadPosts();
    state.posts.add(newPost);
    emit(PostsCreateSuccess(posts: state.posts));
  }

  Future<void> editPost({
    required Post editedPost,
  }) async {
    final index =
        state.posts.indexWhere((element) => element.id == editedPost.id);
    state.posts.removeAt(index);
    state.posts.insert(index, editedPost);
    emit(PostsEditSuccess(posts: state.posts));
  }

  Future<void> deletePost({
    required Post post,
    required int postIndex,
  }) async {
    emit(PostsDeleteInProgress(posts: state.posts));
    try {
      // Immediately remove from list to avoid exceptions from dismissible
      state.posts.removeAt(postIndex);
      await postsRepository.deletePost(post: post);
      emit(PostsDeleteSuccess(postId: post.id ?? -1, posts: state.posts));
    } on Object catch (e) {
      emit(PostsDeleteError(postId: post.id ?? -1, posts: state.posts));
      log(e.toString());
    }
  }
}
