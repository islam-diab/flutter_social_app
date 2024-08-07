part of 'single_post_cubit.dart';

class SinglePostState extends Equatable {
  const SinglePostState({
    this.userApp,
    this.isLikePost = false,
    required this.postData,
    required this.commentController,
    this.userInteraction = const {},
  });
  final UserApp? userApp;
  final bool isLikePost;
  final PostModel postData;
  final TextEditingController commentController;
  final Map<String, UserApp> userInteraction;
  SinglePostState copyWith({
    UserApp? userApp,
    bool? isLikePost,
    PostModel? postData,
    Map<String, UserApp>? userInteraction,
  }) =>
      SinglePostState(
        userApp: userApp ?? this.userApp,
        isLikePost: isLikePost ?? this.isLikePost,
        postData: postData ?? this.postData,
        commentController: commentController,
        userInteraction: userInteraction ?? this.userInteraction,
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        isLikePost,
        postData,
        commentController,
        userInteraction,
      ];
}
