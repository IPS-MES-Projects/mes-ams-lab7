import 'package:posts_api/posts_api.dart';
import 'package:retrofit/retrofit.dart';

part 'posts_api.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PostsApi {
  factory PostsApi(Dio dio, {String baseUrl}) = _PostsApi;

  @GET('/posts')
  Future<List<Post>> getPosts();

  @POST('/posts')
  Future<Post> createPost({
    @Body() required Post post,
  });

  @PUT('/posts/{id}')
  Future<Post> updatePost({
    @Path() required int id,
    @Body() required Post post,
  });

  @DELETE('/posts/{id}')
  Future<void> deletePost({
    @Path() required int id,
  });
}
