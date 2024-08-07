import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/configuration/controller_app/app_controller_cubit.dart';
import 'package:my_app/configuration/controller_app/app_controller_state.dart';
import 'package:my_app/core/enum/dialog_types.dart';
import 'package:my_app/core/helper/app_data/app_data.dart';
import 'package:my_app/core/helper/extensions/navigator.dart';
import 'package:my_app/core/helper/spase.dart';
import 'package:my_app/core/routing/routes.dart';
import 'package:my_app/core/theming/color.dart';
import 'package:my_app/core/theming/text_styles.dart';
import 'package:my_app/data/model/post_model.dart';
import 'package:my_app/feature/home/post/cubit/post_cubit.dart';
import 'package:my_app/feature/home/ui/widget/animated_toggle_switch.dart';
import 'package:my_app/feature/home/ui/widget/custom_app_bar.dart';
import 'package:my_app/feature/registration/data/api/firebase_datastore_api.dart';
import 'package:my_app/feature/registration/data/repository/firebase_database_repo.dart';

import '../../../core/widget/custtom_widget/app_text.dart';
import '../post/ui/post_view.dart';

part 'widget/drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider<PostCubit>(
      create: (context) => PostCubit(
          firebaseDatabaseRepo: FirebaseDatabaseRepo(
        FirebaseDatastoreApi(),
      )),
      child: Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(
          child: _Drawer(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.addPost, (route) => true);
          },
          backgroundColor: Colors.indigo,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            CustomAppBar(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                switch (state.postState) {
                  case DialogTypes.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case DialogTypes.error:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(text: state.error),
                        IconButton(
                          onPressed: () =>
                              context.read<PostCubit>().getListPost(),
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    );
                  case DialogTypes.success:
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          PostModel post = state.posts.elementAt(index);
                          return PostView(
                            scaffoldKey: scaffoldKey,
                            postModel: post,
                          );
                        },
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
