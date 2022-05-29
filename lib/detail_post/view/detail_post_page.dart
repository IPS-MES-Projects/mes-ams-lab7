import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mes_ams_lab7/detail_post/cubit/detail_post_cubit.dart';
import 'package:mes_ams_lab7/l10n/l10n.dart';
import 'package:mes_ams_lab7/utils/utils.dart' show showSnackbar;
import 'package:posts_repository/posts_repository.dart';

enum PostAction {
  view,
  create,
  edit,
}

class DetailPostPage extends StatefulWidget {
  const DetailPostPage._internal({
    required this.action,
    this.post,
  });

  static Route<Post> _route({
    required PostAction postAction,
    Post? post,
  }) {
    return MaterialPageRoute<Post>(
      builder: (context) {
        return BlocProvider(
          create: (context) => DetailPostCubit(
            postsRepository: context.read<PostsRepository>(),
          ),
          child: DetailPostPage._internal(
            action: postAction,
            post: post,
          ),
        );
      },
    );
  }

  static Route<Post> routeView({
    required Post post,
  }) {
    return _route(
      postAction: PostAction.view,
      post: post,
    );
  }

  static Route<Post> routeCreate() {
    return _route(
      postAction: PostAction.create,
    );
  }

  static Route<Post> routeEdit({required Post post}) {
    return _route(
      postAction: PostAction.edit,
      post: post,
    );
  }

  final PostAction action;
  final Post? post;

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Post? get _currentPost => widget.post;
  bool get _isCreate => widget.action == PostAction.create;
  bool get _isReadOnly => widget.action == PostAction.view;

  late double _userId;
  late String _title;
  late String _body;

  @override
  void initState() {
    super.initState();
    _userId = _isCreate ? 1 : _currentPost!.userId.toDouble();
    _title = _isCreate ? '' : _currentPost!.title;
    _body = _isCreate ? '' : _currentPost!.body;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getPageTitle(context)),
      ),
      floatingActionButton: _isReadOnly
          ? null
          : FloatingActionButton(
              onPressed: _submitForm,
              child: const Icon(Icons.save),
            ),
      body: BlocConsumer<DetailPostCubit, DetailPostState>(
        listener: (context, state) {
          if (state is PostCreateSuccess) {
            showSnackbar(context, l10n.postCreateSuccess(state.post.id ?? -1));
            Navigator.of(context).pop(state.post);
          } else if (state is PostCreateError) {
            showSnackbar(context, l10n.postCreateError);
          } else if (state is PostEditSuccess) {
            showSnackbar(context, l10n.postEditSuccess(state.post.id ?? -1));
            Navigator.of(context).pop(state.post);
          } else if (state is PostEditError) {
            showSnackbar(context, l10n.postEditError);
          }
        },
        builder: (context, state) {
          if (state is PostRequestInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(l10n.userIdLabel),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.red,
                            divisions: 10,
                            label: _userId.toInt().toString(),
                            min: 1,
                            max: 10,
                            value: _userId,
                            onChanged: _isReadOnly
                                ? null
                                : (value) {
                                    setState(() {
                                      _userId = value;
                                    });
                                  },
                          ),
                        ),
                        Text(
                          _userId.toInt().toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextFormField(
                      initialValue: _title,
                      readOnly: _isReadOnly,
                      maxLength: 100,
                      decoration: InputDecoration(
                        labelText: l10n.titleLabel,
                        hintText: l10n.titleHint,
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? false) {
                          return 'You have to insert a title.';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        setState(() {
                          _title = value ?? '';
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: _body,
                      readOnly: _isReadOnly,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: l10n.bodyLabel,
                        hintText: l10n.bodyHint,
                      ),
                      onSaved: (String? value) {
                        setState(() {
                          _body = value ?? '';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getPageTitle(BuildContext context) {
    final l10n = context.l10n;

    switch (widget.action) {
      case PostAction.view:
        return l10n.viewPost;
      case PostAction.create:
        return l10n.createPost;
      case PostAction.edit:
        return l10n.editPost;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final post = Post(
        id: _currentPost?.id,
        userId: _userId.toInt(),
        title: _title,
        body: _body,
      );

      final detailPostCubit = BlocProvider.of<DetailPostCubit>(context);
      if (widget.action == PostAction.create) {
        detailPostCubit.createPost(
          post: post,
        );
      } else if (widget.action == PostAction.edit) {
        detailPostCubit.editPost(
          post: post,
        );
      }
    }
  }
}
