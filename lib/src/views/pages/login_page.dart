import 'package:contact_app/src/controller/authentication/auth_cubit.dart';
import 'package:contact_app/src/core/common_widgets/appbtn.dart';
import 'package:contact_app/src/core/constants/strings.dart';
import 'package:contact_app/src/core/helpers/validation_helper.dart';
import 'package:contact_app/src/views/pages/contacts_page.dart';
import 'package:contact_app/src/views/pages/new_contact_page.dart';
import 'package:contact_app/src/views/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController emailTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          body: SafeArea(
              child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center, //x-axis
              mainAxisAlignment: MainAxisAlignment.center, //y-axis
              children: [
                TextFormField(
                  controller: emailTextController,
                  validator: ValidationHelper.validateEmail,
                  decoration: InputDecoration(
                    label: Text(Strings.email),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: passwordTextController,
                  validator: ValidationHelper.validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(Strings.password),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateAuthenticate) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewContactPage()));
                      return;
                    }

                    if (state is AuthStateUnauthenticate) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Error message"),
                                content: Text(state.error),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                              ));
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthStateLoading) {
                        return CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                      return AppBtn(
                          buttonTitle: Strings.loginBtnTxt,
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              String email = emailTextController.text;
                              String password = passwordTextController.text;

                              context.read<AuthCubit>().login(email, password);
                            }
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: Strings.askNewUser,
                    ),
                    TextSpan(
                        text: Strings.signupBtnTxt,
                        style: TextStyle(color: Colors.lightBlue)),
                  ])),
                ),
              ]),
        ),
      ))),
    );
  }
}
