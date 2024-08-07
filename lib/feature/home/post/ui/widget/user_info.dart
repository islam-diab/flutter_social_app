part of '../post_view.dart';

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    required this.userName,
    required this.userEmail,
    required this.imagePerson,
  });
  final String userName;
  final String? userEmail;
  final String? imagePerson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.w,
            backgroundColor: Colors.red.shade100,
            backgroundImage:
                imagePerson != null ? NetworkImage(imagePerson!) : null,
            child: imagePerson != null
                ? null
                : const Center(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AppTextStyles.font18Bold,
                ),
                userEmail == null
                    ? const SizedBox()
                    : Text(
                        userEmail!,
                        style: AppTextStyles.font16Regular,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
