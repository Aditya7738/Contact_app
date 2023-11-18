import 'package:contact_app/src/controller/authentication/auth_cubit.dart';
import 'package:contact_app/src/controller/contact_cubit/contact_cubit.dart';
import 'package:contact_app/src/core/common_widgets/app_text_form_field.dart';
import 'package:contact_app/src/core/common_widgets/appbtn.dart';
import 'package:contact_app/src/core/constants/strings.dart';
import 'package:contact_app/src/models/signupModel.dart';
import 'package:contact_app/src/views/pages/new_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:contact_app/src/core/helpers/validation_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _dobController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    String password;
    String? confirmPassword = null;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          body: SafeArea(
              child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center, //x-axis
              mainAxisAlignment: MainAxisAlignment.center, //y-axis
              children: [
                AppTextFormField(
                    label: Strings.fullName,
                    textEditingController: _nameController,
                    validator: ValidationHelper.validateName),
                SizedBox(
                  height: 20.0,
                ),
                AppTextFormField(
                    label: Strings.email,
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                    validator: ValidationHelper.validateEmail),
                SizedBox(
                  height: 20.0,
                ),
                AppTextFormField(
                  label: Strings.dob,
                  validator: ValidationHelper.checkIsNullOrEmpty,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1950),
                        initialDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 18)),
                        lastDate: DateTime.now()
                            .subtract(const Duration(days: 365 * 5)));

                    selectedDate ??=
                        DateTime.now().subtract(const Duration(days: 365 * 18));

                    _dobController.text =
                        selectedDate.toString().substring(0, 10);
                  },
                  keyboardType: TextInputType.datetime,
                  textEditingController: _dobController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                AppTextFormField(
                  label: Strings.phoneNo,
                  keyboardType: TextInputType.phone,
                  validator: ValidationHelper.validatePhone,
                  textEditingController: _phoneController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                AppTextFormField(
                  label: Strings.password,
                  isObscure: true,
                  validator: ValidationHelper.validatePassword,
                  textEditingController: _passwordController,
                ),
                SizedBox(
                  height: 20.0,
                ),
                AppTextFormField(
                  label: Strings.confirmPassword,
                  isObscure: true,
                  validator: (val) {
                    return ValidationHelper.passwordMatch(
                        _passwordController.text, val);
                  },
                  textEditingController: _confirmPasswordController,
                ),
                SizedBox(
                  height: 40.0,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateAuthenticate) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewContactPage()));
                      return;
                    }

                    if (state is AuthStateUnauthenticate) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          AuthStateUnauthenticate stateNew =
                              state as AuthStateUnauthenticate;
                          return AlertDialog(
                            title: Text(Strings.registerErrorMsg),
                            content: Text(stateNew.error),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(Strings.registerAlertBtn))
                            ],
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthStateLoading) {
                      return CircularProgressIndicator();
                    }
                    return AppBtn(
                        buttonTitle: Strings.signupBtnTxt,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            String email = _emailController.text.trim();
                            String name = _nameController.text.trim();
                            String password = _passwordController.text;
                            String phone = _phoneController.text.trim();
                            String dob = _dobController.text.trim();

                            SignupModel signupModel = SignupModel(
                                name: name,
                                phone: phone,
                                email: email,
                                dob: dob,
                                password: password);
                            context.read<AuthCubit>().signUp(signupModel);
                          }
                        });
                  },
                )
              ]),
        ),
      ))),
    );
  }
}
