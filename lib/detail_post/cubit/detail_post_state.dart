part of 'detail_post_cubit.dart';

@immutable
abstract class DetailPostState extends Equatable {
  const DetailPostState();

  @override
  List<Object?> get props => [];
}

class DetailPostInitial extends DetailPostState {}

class PostRequestInProgress extends DetailPostState {}

class PostCreateSuccess extends DetailPostState {
  const PostCreateSuccess({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

class PostCreateError extends DetailPostState {}

class PostEditSuccess extends DetailPostState {
  const PostEditSuccess({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

class PostEditError extends DetailPostState {}
