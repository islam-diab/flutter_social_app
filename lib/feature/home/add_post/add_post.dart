import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/helper/extensions/navigator.dart';
import 'package:my_app/core/routing/routes.dart';
import 'package:my_app/core/widget/auth/text_form_field.dart';
import 'package:my_app/core/widget/custtom_widget/app_text.dart';
import 'package:my_app/feature/home/add_post/cubit/add_new_post_cubit.dart';

import '../../../core/enum/dialog_types.dart';

part 'widget/images_post.dart';
part 'widget/post_content.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddNewPostCubit>(
      create: (context) => AddNewPostCubit(),
      child: BlocListener<AddNewPostCubit, AddNewPostState>(
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
              ).whenComplete(
                  () => context.read<AddNewPostCubit>().resetDialog());
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
                  () => context.read<AddNewPostCubit>().resetDialog());
              break;
            case DialogTypes.success:
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.homeScreen, (route) => true);
            default:
          }
        },
        listenWhen: (previous, current) =>
            previous.dialogTypes != current.dialogTypes,
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const AppText(
                text: 'Add Post',
              ),
              actions: [
                IconButton(
                  onPressed: () =>
                      context.read<AddNewPostCubit>().addPost(context),
                  icon: const Icon(Icons.post_add),
                ),
              ],
            ),
            body: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _PostContent(),
                ),
                Expanded(child: _PickedImages()),
              ],
            ),
          );
        }),
      ),
    );
  }
}
