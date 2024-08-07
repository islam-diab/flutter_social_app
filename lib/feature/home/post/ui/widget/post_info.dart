part of '../post_view.dart';

class _PostInfo extends StatelessWidget {
  const _PostInfo({required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePostCubit, SinglePostState>(
      buildWhen: (previous, current) => previous.userApp != current.userApp,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.showBottomSheet(
                      constraints:
                          BoxConstraints(maxHeight: 500.h, minHeight: 20.h),
                      (contextB) => BlocProvider.value(
                            value: context.read<SinglePostCubit>(),
                            child: const _CommentsView(),
                          ));
                },
                icon: const Icon(Icons.chat_outlined),
              ),
              horizontalSpace(5),
              BlocSelector<SinglePostCubit, SinglePostState, bool>(
                selector: (state) => state.isLikePost,
                builder: (context, isLikePost) {
                  return IconButton(
                    onPressed: () =>
                        context.read<SinglePostCubit>().likePost(isLikePost),
                    icon: Icon(
                      isLikePost ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  );
                },
              ),
              horizontalSpace(150),
              const IconForPost(
                image: 'assets/home/send.png',
              ),
              horizontalSpace(5),
              const IconForPost(
                image: 'assets/home/subtract.png',
              ),
            ],
          ),
        );
      },
    );
  }
}
