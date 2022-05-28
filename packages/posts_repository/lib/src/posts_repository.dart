import 'package:posts_api/posts_api.dart';

class PostsRepository {
  const PostsRepository({
    required PostsApi postsApi,
  }) : _postsApi = postsApi;

  final PostsApi _postsApi;

  Future<List<Post>> getPosts() => _postsApi.getPosts();

  Future<Post> createPost({
    required Post post,
  }) =>
      _postsApi.createPost(
        post: post,
      );

  Future<Post> updatePost({
    required int id,
    required Post post,
  }) =>
      _postsApi.updatePost(
        id: id,
        post: post,
      );

  Future<void> deletePost({
    required int id,
  }) =>
      _postsApi.deletePost(
        id: id,
      );
}
