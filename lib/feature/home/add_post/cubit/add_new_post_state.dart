part of 'add_new_post_cubit.dart';

@immutable
class AddNewPostState extends Equatable {
  const AddNewPostState({
    required this.postController,
    this.images = const [],
    this.dialogTypes = DialogTypes.initial,
    this.errorMessage = '',
  });
  final TextEditingController postController;
  final List<String> images;
  final DialogTypes dialogTypes;
  final String errorMessage;

  AddNewPostState copyWith(
          {TextEditingController? postController,
          List<String>? images,
          DialogTypes? dialogTypes,
          String? errorMessage}) =>
      AddNewPostState(
        postController: postController ?? this.postController,
        images: images ?? this.images,
        dialogTypes: dialogTypes ?? this.dialogTypes,
        errorMessage: errorMessage ?? this.errorMessage,
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        postController,
        images,
        dialogTypes,
        errorMessage,
      ];
}
