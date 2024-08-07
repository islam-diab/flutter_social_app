part of '../post_view.dart';

class _CommentsView extends StatelessWidget {
  const _CommentsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SinglePostCubit, SinglePostState>(
      builder: (context, state) {
        return Column(children: [
          verticalSpace(5),
          SizedBox(
            height: 22.h,
            child: Center(
                child: Container(
              height: 7.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.r),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Center(child: Text('Likes')),
                    content: SizedBox(
                      height: 100.h,
                      width: 50.w,
                      child: ListView.builder(
                        itemCount: state.postData.whoLikes.length,
                        itemBuilder: (context, index) {
                          String likes =
                              state.postData.whoLikes.elementAt(index);
                          UserApp? userApp = state.userInteraction[likes];

                          return _SingleComment(
                              userApp: userApp, commentContent: null);
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  horizontalSpace(5),
                  Text(state.postData.whoLikes.length.toString()),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.postData.comments.length,
              itemBuilder: (context, index) {
                CommentModel comment = state.postData.comments.elementAt(index);
                UserApp? userApp = state.userInteraction[comment.userId];
                return _SingleComment(
                  commentContent: comment.commentContent,
                  userApp: userApp,
                );
              },
            ),
          ),
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextFormField(
                  suffixIcon: IconButton(
                    onPressed: () =>
                        context.read<SinglePostCubit>().addComments(),
                    icon: const Icon(Icons.send),
                  ),
                  textInputAction: TextInputAction.send,
                  hintText: 'Write a comment',
                  prefixIcon: const Icon(Icons.comment),
                  controller: state.commentController,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ])
        ]);
      },
    );
  }
}
