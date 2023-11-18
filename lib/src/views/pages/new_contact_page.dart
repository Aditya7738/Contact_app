import 'package:contact_app/src/controller/contact_cubit/contact_cubit.dart';
import 'package:contact_app/src/core/common_widgets/appbtn.dart';
import 'package:contact_app/src/core/constants/strings.dart';
import 'package:contact_app/src/models/contactRequestModel.dart';
import 'package:contact_app/src/views/pages/create_new_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit()..readContact(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
            onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => CreateNewContact(),
            ),
          )
              .then((value) {
            context.read<ContactCubit>().readContact();
          });
        }),
        body: SafeArea(
          child: BlocConsumer<ContactCubit, ContactState>(
            listener: (context, state) {
              if (state is ContactDeleteSuccess) {
                Fluttertoast.showToast(msg: Strings.successDelete);
                context.read<ContactCubit>().readContact();
                return;
              }
              if (state is ContactDeleteError) {
                Fluttertoast.showToast(msg: Strings.unsuccessDelete);
                return;
              }
            },
            builder: (context, state) {
              if (state is ContactReadLoading ||
                  state is ContactDeleteLoading) {
                return CircularProgressIndicator();
              }
              if (state is ContactReadError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Strings.contactNotFoundError,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(Strings.loadingMsg),
                        AppBtn(
                            buttonTitle: Strings.retryBtn,
                            onPressed: () {
                              context.read<ContactCubit>().readContact();
                            }),
                      ]),
                );
              }

              if (state is ContactReadSuccess) {
                List<ContactRequestModel> contacts =
                    state.listOfContactRequestModel;
                return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      ListTile(
                        title: Text(contacts[index].firstName +
                            contacts[index].lastName),
                        trailing: IconButton(
                          onPressed: () {
                            context
                                .read<ContactCubit>()
                                .deleteContact(contacts[index]);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    });
              }
              return SizedBox(
                width: 2.0,
              );
            },
          ),
        ),
      ),
    );
  }
}
