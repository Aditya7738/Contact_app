import 'package:contact_app/src/controller/contact_cubit/contact_cubit.dart';
import 'package:contact_app/src/core/common_widgets/app_text_form_field.dart';
import 'package:contact_app/src/core/common_widgets/appbtn.dart';
import 'package:contact_app/src/core/constants/strings.dart';
import 'package:contact_app/src/core/helpers/validation_helper.dart';
import 'package:contact_app/src/models/contactRequestModel.dart';
import 'package:contact_app/src/views/pages/new_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateNewContact extends StatefulWidget {
  const CreateNewContact({super.key});

  @override
  State<CreateNewContact> createState() => _CreateNewContactState();
}

class _CreateNewContactState extends State<CreateNewContact> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _addressController = TextEditingController();
    return BlocProvider(
      create: (context) => ContactCubit(),
      child: Scaffold(
          body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start, //y-axis
                children: [
                  AppTextFormField(
                    label: Strings.firstName,
                    textEditingController: _firstNameController,
                    validator: ValidationHelper.validateName,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AppTextFormField(
                    label: Strings.lastName,
                    textEditingController: _lastNameController,
                    validator: ValidationHelper.validateName,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AppTextFormField(
                    label: Strings.phoneNo,
                    textEditingController: _phoneController,
                    validator: ValidationHelper.validatePhone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AppTextFormField(
                    label: Strings.email,
                    textEditingController: _emailController,
                    validator: ValidationHelper.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  AppTextFormField(
                    label: Strings.address,
                    textEditingController: _addressController,
                    validator: ValidationHelper.validateAddress,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  BlocConsumer<ContactCubit, ContactState>(
                    listener: (context, state) {
                      if (state is ContactCreateSuccess) {
                        Fluttertoast.showToast(msg: Strings.contactSavedBtn);
                        Navigator.pop(context);
                        return;
                      }
                      if (state is ContactCreateError) {
                        Fluttertoast.showToast(msg: state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is ContactCreateLoading) {
                        return CircularProgressIndicator();
                      }
                      return AppBtn(
                          buttonTitle: Strings.saveBtn,
                          onPressed: () {
                            var firstName;
                            var lastName;
                            var phone;
                            var email;
                            var address;
                            if (_formKey.currentState?.validate() ?? false) {
                              email = _emailController.text.trim();
                              firstName = _firstNameController.text.trim();
                              lastName = _lastNameController.text.trim();
                              phone = _phoneController.text.trim();
                              address = _addressController.text.trim();
                            }

                            ContactRequestModel contactRequestModel =
                                ContactRequestModel(
                                    firstName: firstName,
                                    lastName: lastName,
                                    phone: phone,
                                    email: email,
                                    address: address);
                            context
                                .read<ContactCubit>()
                                .createContact(contactRequestModel);
                          });
                    },
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
