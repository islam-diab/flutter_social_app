part of '../post_view.dart';

class _SingleComment extends StatelessWidget {
  const _SingleComment({
    required this.userApp,
    required this.commentContent,
  });
  final UserApp? userApp;
  final String? commentContent;

  @override
  Widget build(BuildContext context) {
    return _UserInfo(
        imagePerson: userApp?.image,
        userName: userApp?.name ?? 'fs',
        userEmail: commentContent);
  }
}
