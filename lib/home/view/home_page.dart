import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mes_ams_lab7/detail_post/view/detail_post_page.dart';
import 'package:mes_ams_lab7/home/home.dart';
import 'package:mes_ams_lab7/home/widgets/widgets.dart';
import 'package:mes_ams_lab7/l10n/l10n.dart';
import 'package:mes_ams_lab7/utils/show_snackbar.dart';
import 'package:posts_repository/posts_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        postsRepository: context.read<PostsRepository>(),
      )..loadPosts(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createPost(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is PostsLoadError) {
            showSnackbar(context, l10n.postLoadError);
          } else if (state is PostsDeleteSuccess) {
            showSnackbar(context, l10n.postDeleteSuccess(state.postId));
          } else if (state is PostsDeleteError) {
            showSnackbar(context, l10n.postDeleteError(state.postId));
          }
        },
        builder: (context, state) {
          if (state is PostsLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final posts = state.posts;
          return ListView.separated(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              final post = posts.elementAt(index);
              return PostListTile(
                post: post,
                onTap: () => _viewPost(
                  context,
                  post,
                ),
                onDismissed: () => _deletePost(
                  context,
                  post,
                  index,
                ),
                onDelete: (BuildContext context) => _deletePost(
                  context,
                  post,
                  index,
                ),
                onEdit: (BuildContext context) => _editPost(
                  context,
                  post,
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }

  Future<void> _createPost(BuildContext context) async {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    final newPost = await Navigator.of(context).push<Post>(
      DetailPostPage.routeCreate(),
    );
    if (newPost == null) return;

    await homeCubit.createPost(newPost: newPost);
  }

  void _viewPost(BuildContext context, Post post) {
    Navigator.of(context).push<void>(
      DetailPostPage.routeView(
        post: post,
      ),
    );
  }

  Future<void> _editPost(BuildContext context, Post post) async {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    final editedPost = await Navigator.of(context).push<Post>(
      DetailPostPage.routeEdit(
        post: post,
      ),
    );
    if (editedPost == null) return;

    await homeCubit.editPost(editedPost: editedPost);
  }

  void _deletePost(BuildContext context, Post post, int postIndex) {
    BlocProvider.of<HomeCubit>(context).deletePost(
      post: post,
      postIndex: postIndex,
    );
  }
}
