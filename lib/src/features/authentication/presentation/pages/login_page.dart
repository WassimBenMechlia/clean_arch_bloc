import 'dart:io';
import 'package:clean_arch_bloc/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:clean_arch_bloc/src/features/authentication/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';


import '../../../../../cores/util/const_colors.dart';
import '../../../../../cores/util/services/injection_container.dart';
import '../../../../../welcomePage.dart';
import '../widgets/inputs.dart';

class LogInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    void loginBtn(BuildContext context) async {
      if (_formKey.currentState?.validate() ?? false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const AlertDialog(
              insetPadding: EdgeInsets.all(100),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Logging in..."),
                ],
              ),
            );
          },
        );
        context.read<AuthenticationBloc>().add(LogInEvent(
            mail: emailController.text, password: passwordController.text));
      }
    }

    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const WelcomePage()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Successful!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AuthenticationFailure) {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Failed: ${state.appException?.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                              'assets/smart_way/smar_way_logo.png',
                              height: 150),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'E-mail address',
                      style: TextStyle(
                          color: ConstColor.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Inputs(
                      controller: emailController,
                      icon: Icons.mail,
                      validator: ValidationBuilder().email(),
                      obscure: false,
                      placeholder: 'Email',
                      hintText: "Abc@exmaple.com",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                          color: ConstColor.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Inputs(
                      controller: passwordController,
                      icon: Icons.lock_open,
                      validator: ValidationBuilder().minLength(3),
                      obscure: true,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot password ?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ConstColor.mainColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.width * 0.3),
                      child: Buttons(
                        buttonText: 'Connect',
                        color: Colors.white,
                        textColor: ConstColor.mainColor,
                        borderColor: ConstColor.mainColor,
                        onPageFunction: () {
                          loginBtn(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ConstColor.mainColor),
                      TextSpan(
                        children: [
                          const TextSpan(text: "You don't have an account?  "),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Create an account',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.grey[500],
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
