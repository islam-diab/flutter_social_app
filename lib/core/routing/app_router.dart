import 'package:flutter/material.dart';
import 'package:my_app/core/routing/routes.dart';
import 'package:my_app/feature/home/add_post/add_post.dart';
import 'package:my_app/feature/home/ui/home_view.dart';
import 'package:my_app/feature/login/ui/screen/login_view.dart';
import 'package:my_app/feature/profile/ui/profile.dart';
import 'package:my_app/feature/signup/ui/signup_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../feature/registration/ui/registration_view.dart';
import '../../feature/splash/ui/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );

      case Routes.registrationScreen:
        return MaterialPageRoute(
          builder: (_) => const RegistrationView(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignupView(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );
      case Routes.addPost:
        return PageTransition(
          child: const AddPost(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );
      case Routes.viewProfile:
        return PageTransition(
          child: ViewProfile(
            userApp: (settings.arguments as List).first,
          ),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
          reverseDuration: const Duration(milliseconds: 400),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route define in ${settings.name}'),
            ),
          ),
        );
    }
  }
}
