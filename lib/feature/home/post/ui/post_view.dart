import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/core/helper/extensions/navigator.dart';
import 'package:my_app/core/theming/color.dart';
import 'package:my_app/core/theming/text_styles.dart';
import 'package:my_app/core/widget/auth/text_form_field.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/feature/home/post/components/cubit/single_post_cubit.dart';
import 'package:my_app/feature/registration/data/model/users_app.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

import '../../../../core/helper/spase.dart';
import '../../../../core/routing/routes.dart';
import '../../../../data/model/comment_model.dart';
import '../../../registration/data/api/firebase_datastore_api.dart';
import '../../ui/widget/icon_for_post.dart';

part 'widget/comments_view.dart';
part 'widget/post_info.dart';
part 'widget/single_comment.dart';
part 'widget/user_info.dart';

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    required this.postModel,
    required this.scaffoldKey,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SinglePostCubit>(
      create: (contextB) => SinglePostCubit(
        context: context,
        postModel: postModel,
        firebaseDatabaseRepo: FirebaseDatabaseRepo(FirebaseDatastoreApi()),
        scaffoldKey: scaffoldKey,
      ),
      child: BlocBuilder<SinglePostCubit, SinglePostState>(
        buildWhen: (previous, current) => previous.userApp != current.userApp,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 10.h),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.backgroundColorHome,
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pushNamedAndRemoveUntil(Routes.viewProfile,
                              arguments: [state.userApp],
                              predicate: (Route<dynamic> route) => false);
                        },
                        child: _UserInfo(
                          userName: state.userApp?.name ?? 'unknown',
                          userEmail: state.userApp?.email ?? 'unknown',
                          imagePerson: state.userApp?.image,
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              onTap: () async {
                                if (state.userApp?.id ==
                                    context.read<AppData>().getUser!.id) {
                                  return context
                                      .read<SinglePostCubit>()
                                      .deletePost();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        'con\'t delete this post, it\'s not yours',
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: const Text('delete'),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Error when editing, please try again',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text('edit'),
                            )
                          ];
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(postModel.contentPost,
                        style: AppTextStyles.font18Bold),
                  ),
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: postModel.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              postModel.images.elementAt(index),
                            ),
                          );
                        }),
                  ),
                  _PostInfo(
                    scaffoldKey: scaffoldKey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
