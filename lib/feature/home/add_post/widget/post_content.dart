part of '../add_post.dart';

class _PostContent extends StatelessWidget {
  const _PostContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return AppTextFormField(
          hintText: 'Add Post',
          maxLine: 5,
          keyboardType: TextInputType.text,
          controller: state.postController,
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
