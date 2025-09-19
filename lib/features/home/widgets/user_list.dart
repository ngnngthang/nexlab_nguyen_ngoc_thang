import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nguyen_ngoc_thang_nexlab/models/models.dart';

class UserList extends StatelessWidget {
  const UserList({super.key, this.users = const [], this.onRemove});

  final List<User> users;
  final void Function(User user)? onRemove;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? Center(child: Text('No contacts available'))
        : ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final user = users[index];

              return Dismissible(
                key: Key(user.id.toString()),
                direction: DismissDirection.endToStart,
                dragStartBehavior: DragStartBehavior.start,
                onDismissed: (direction) {
                  onRemove?.call(user);
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text(
                          'Are you sure you want to delete this contact?',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: UserItem(user: user),
              );
            },
          );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Image.network(
            user.image ?? 'https://placehold.co/400',
            width: 80,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: 80,
                height: 80,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone, size: 16),
                      Expanded(child: Text(user.phone)),
                    ],
                  ),
                  if (user.email != null || user.email!.isNotEmpty)
                    Row(
                      spacing: 4,
                      children: [
                        const Icon(Icons.email, size: 16),
                        Expanded(child: Text(user.email!)),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
