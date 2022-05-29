import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mes_ams_lab7/l10n/l10n.dart';
import 'package:posts_repository/posts_repository.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    required this.post,
    required this.onTap,
    required this.onDismissed,
    required this.onEdit,
    required this.onDelete,
  });

  final Post post;
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final SlidableActionCallback onEdit;
  final SlidableActionCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: Key('postListTile_slidable_${post.id}'),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const BehindMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: onDismissed),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: onEdit,
            backgroundColor: Colors.blue.shade200,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: l10n.edit,
          ),
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: l10n.delete,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(
        onTap: onTap,
        title: Text(
          post.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          post.body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
