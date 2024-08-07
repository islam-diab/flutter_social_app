import 'package:flutter/material.dart';
import 'package:my_app/feature/signup/ui/widget/container_info_signup.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Image.asset('assets/auth/image/logo2.png'),
              Stack(
                children: [
                  Image.asset(
                    'assets/auth/image/2.png',
                  ),
                  const ContainerInfoForSignup(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
