part of 'splash_cubit.dart';

@immutable
class SplashState extends Equatable {
  const SplashState({
    this.navigatorSplash = NavigatorSplash.init,
  });
  final NavigatorSplash navigatorSplash;
  SplashState copyWith({
    NavigatorSplash? navigatorSplash,
  }) =>
      SplashState(
        navigatorSplash: navigatorSplash ?? this.navigatorSplash,
      );

  @override
  List<Object> get props => [
        navigatorSplash,
      ];
}
