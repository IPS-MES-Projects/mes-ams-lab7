part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState({
    required this.posts,
  });

  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(posts: const []);
}

class PostsLoadInProgress extends HomeState {
  const PostsLoadInProgress({required super.posts});
}

class PostsLoadSuccess extends HomeState {
  const PostsLoadSuccess({required super.posts});
}

class PostsLoadError extends HomeState {
  const PostsLoadError({required super.posts});
}

class PostsCreateSuccess extends HomeState {
  const PostsCreateSuccess({required super.posts});
}

class PostsEditSuccess extends HomeState {
  const PostsEditSuccess({required super.posts});
}

class PostsDeleteInProgress extends HomeState {
  const PostsDeleteInProgress({required super.posts});
}

class PostsDeleteSuccess extends HomeState {
  const PostsDeleteSuccess({required this.postId, required super.posts});

  final int postId;

  @override
  List<Object?> get props => [postId];
}

class PostsDeleteError extends HomeState {
  const PostsDeleteError({required this.postId, required super.posts});

  final int postId;

  @override
  List<Object?> get props => [postId];
}
