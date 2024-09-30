import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'src/features/authentication/presentation/pages/login_page.dart';
import 'welcomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.read<AuthenticationBloc>().add(const CheckUserLoggedInEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        // Trigger navigation based on the updated authentication state
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
          );
        } else if (state is UnAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LogInPage(),
            ),
          );
        }
      },
      child: Center(
        child: Image.asset('assets/splashh.png'),
      ),
    ));
  }
}
