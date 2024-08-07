part of '../home_view.dart';

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 70.0.h, left: 20.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColor.backgroundColorHome,
                backgroundImage: context.read<AppData>().getUser!.image != null
                    ? NetworkImage(context.read<AppData>().getUser!.image!)
                    : const NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/my-app-f4503.appspot.com/o/islam.png?alt=media&token=e4038cd7-ff14-4b89-a516-374e051f02fa'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.read<AppData>().getUser!.name,
                      style: AppTextStyles.font20SemiBold,
                    ),
                    verticalSpace(4.h),
                    Text(
                      context.read<AppData>().getUser!.email,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            context.pushNamedAndRemoveUntil(Routes.viewProfile,
                arguments: [context.read<AppData>().getUser],
                predicate: (Route<dynamic> route) => false);
          },
          child: const Text(
            'View Profile',
          ),
        ),
        ListTile(
          title: const Text('Mode'),
          trailing:
              BlocSelector<AppControllerCubit, AppControllerState, Brightness>(
            selector: (state) => state.brightness,
            builder: (context, state) {
              return DayNightSwitcher(
                isDarkModeEnabled: state == Brightness.dark,
                onStateChanged: (bool isDarkModeEnabled) {
                  context.read<AppControllerCubit>().changeTheme(
                      isDarkModeEnabled ? Brightness.dark : Brightness.light);
                },
              );
            },
          ),
        ),
        const ListTile(
          title: Text('Language'),
          trailing: CustomSwitch(),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.registrationScreen, (route) => false);
          },
          child: const Text('SignOut'),
        ),
      ],
    );
  }
}
