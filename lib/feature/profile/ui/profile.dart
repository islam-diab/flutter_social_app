import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/extensions/navigator.dart';
import 'package:my_app/core/routing/routes.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/feature/home/post/cubit/post_cubit.dart';
import 'package:my_app/feature/profile/logic/profile_cubit.dart';
import 'package:my_app/feature/registration/data/api/firebase_datastore_api.dart';
import 'package:my_app/feature/registration/data/model/users_app.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

import '../../../core/enum/dialog_types.dart';
import '../../../core/widget/custtom_widget/app_text.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key, required this.userApp});

  final UserApp userApp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextB) => ProfileCubit(context: context, userApp: userApp),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.pushNamedAndRemoveUntil(Routes.homeScreen,
                    predicate: (context) => false);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 30,
              )),
          title: const Text(
            'Profile',
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return SafeArea(
              top: true,
              child: ListView(
                children: [
                  SizedBox(
                    height: 290.h,
                    child: Stack(
                      children: [
                        const _BackImage(),
                        Align(
                          alignment: const AlignmentDirectional(0, 1),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: const CircleBorder(),
                            child: Container(
                              width: 130.h,
                              height: 130.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.w,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50).r,
                                  child: _PersonImage(userApp: userApp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: userApp.name,
                            textSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          if (state.isMyProfile)
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit))
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: AppText(
                        text: userApp.email,
                        textColor: Colors.black45,
                        textSize: 18.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F4F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: _UserInfo(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Posts',
                          textSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          width: 140.w,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: 'All',
                                fontWeight: FontWeight.w700,
                              ),
                              AppText(
                                text: 'Photos',
                                fontWeight: FontWeight.w700,
                              ),
                              AppText(
                                text: 'Videos',
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocProvider(
                      create: (context) => PostCubit(
                          firebaseDatabaseRepo:
                              FirebaseDatabaseRepo(FirebaseDatastoreApi())),
                      child: BlocBuilder<PostCubit, PostState>(
                        builder: (context, state) {
                          List<PostModel> posts = List.from(state.posts);
                          List<PostModel> myPosts = [];
                          for (int x = 0; x < posts.length; x++) {
                            if (userApp.id ==
                                state.posts.elementAt(x).idUserPost) {
                              myPosts.add(posts.elementAt(x));
                            }
                          }
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 9.0,
                              mainAxisSpacing: 9.0,
                            ),
                            itemCount: myPosts.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  myPosts.elementAt(index).images.first,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PersonImage extends StatelessWidget {
  const _PersonImage({
    required this.userApp,
  });

  final UserApp userApp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAdaptiveDialog(
          context: context,
          builder: (builder) => AlertDialog(
            content: SizedBox(
              height: 130.h,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const AppText(text: 'View Image'),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.read<ProfileCubit>().updateImageProfile(),
                    child: const AppText(text: 'Edit Image'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) async {
          switch (state.dialogTypes) {
            case DialogTypes.loading:
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Loading...'),
                  content: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: const Center(child: CircularProgressIndicator())),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                ),
              ).whenComplete(() => context.read<ProfileCubit>().resetDialog());
              break;

            case DialogTypes.error:
              if (!context.mounted) return;
              context.pop();
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Error!'),
                        content: SingleChildScrollView(
                          child: Text(state.errorMessage),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('Ok'))
                        ],
                      )).whenComplete(
                  () => context.read<ProfileCubit>().resetDialog());
              break;
            case DialogTypes.success:
              if (!context.mounted) return;
              context.pop();
              context.pop();

            default:
          }
        },
        // context.read<AppData>().getUser!.image != null
        //     ? NetworkImage(context.read<AppData>().getUser!.image!)
        //     : Icon(
        //   Icons.person,
        //   size: 40.r,
        //   color: Colors.black,
        // ) as ImageProvider,
        listenWhen: (previous, current) =>
            previous.dialogTypes != current.dialogTypes,
        child: userApp.image != null
            ? Image.network(
                context.read<ProfileCubit>().state.userApp.image!,
                width: 150.h,
                height: 200.h,
                fit: BoxFit.cover,
              )
            : Image.network(
                'https://firebasestorage.googleapis.com/v0/b/my-app-f4503.appspot.com/o/islam.png?alt=media&token=e4038cd7-ff14-4b89-a516-374e051f02fa',
                width: 150.h,
                height: 200.h,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class _BackImage extends StatelessWidget {
  const _BackImage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://source.unsplash.com/random/1280x720?profile&52',
          width: double.infinity,
          height: 220.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                '1,602',
              ),
            ),
            Text(
              'Item Saves',
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
              child: Text(
                '420',
              ),
            ),
            Text(
              'Followers',
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
              child: Text(
                '15,200',
              ),
            ),
            Text(
              'Item Views',
            ),
          ],
        ),
      ],
    );
  }
}
