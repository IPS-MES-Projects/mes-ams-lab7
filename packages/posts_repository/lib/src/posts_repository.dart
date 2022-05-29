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
    required Post post,
  }) {
    if (post.id == null) {
      throw PostNoId();
    }

    return _postsApi.updatePost(
      id: post.id!,
      post: post,
    );
  }

  Future<void> deletePost({
    required Post post,
  }) {
    if (post.id == null) {
      throw PostNoId();
    }

    return _postsApi.deletePost(
      id: post.id!,
    );
  }
}

/// Error thrown when a [Post] does not have an id.
class PostNoId implements Exception {}
