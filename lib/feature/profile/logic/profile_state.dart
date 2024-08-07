part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool isMyProfile;
  final UserApp userApp;
  final DialogTypes dialogTypes;
  final String errorMessage;

  const ProfileState({
    this.dialogTypes = DialogTypes.initial,
    this.errorMessage = '',
    required this.userApp,
    required this.isMyProfile,
  });
  ProfileState copyWith({
    bool? isMyProfile,
    UserApp? userApp,
    DialogTypes? dialogTypes,
    String? errorMessage,
  }) =>
      ProfileState(
        isMyProfile: isMyProfile ?? this.isMyProfile,
        userApp: userApp ?? this.userApp,
        dialogTypes: dialogTypes ?? this.dialogTypes,
        errorMessage: errorMessage ?? this.errorMessage,
      );
  @override
  // TODO: implement props
  List<Object?> get props => [
        isMyProfile,
        userApp,
        dialogTypes,
        errorMessage,
      ];
}
