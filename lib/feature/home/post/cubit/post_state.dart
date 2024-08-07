part of '../../../../feature/home/post/cubit/post_cubit.dart';

class PostState extends Equatable {
  const PostState({
    this.posts = const [],
    this.postState = DialogTypes.loading,
    this.error = '',
  });
  final List<PostModel> posts;
  final DialogTypes postState;
  final String error;
  PostState copyWith({
    List<PostModel>? posts,
    DialogTypes? postState,
    String? error,
  }) =>
      PostState(
        posts: posts ?? this.posts,
        postState: postState ?? this.postState,
        error: error ?? this.error,
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        posts,
        postState,
        error,
      ];
}
