import 'package:contact_app/src/controller/records_controller.dart';
import 'package:contact_app/src/controller/records_cubit/records_cubit.dart';
import 'package:contact_app/src/models/record.dart';
import 'package:contact_app/src/views/widgets/contact_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Records> records = [];
  String imagepath = 'assests/images/green-call.png';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    RecordsController recordController = RecordsController();
    recordController.getData().then((value) {
      setState(() {
        records = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => RecordsCubit()..getRecordData(),
      child: SafeArea(
          child: BlocBuilder<RecordsCubit, RecordsState>(
        builder: (context, state) {
          if (state is RecordsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecordsSuccess) {
            return ListView.builder(
              itemBuilder: (subContext, index) {
                return ContactListItem(
                    records: state.records[index], imagePath: imagepath);
              },
              itemCount: state.records.length,
            );
          } else if (state is RecordsError) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Error 404",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Oops!! Something went wrong"),
                ]);
          } else {
            //initial state
            return SizedBox(
              width: 8,
            );
          }
        },
      )),
    ));
  }
}
