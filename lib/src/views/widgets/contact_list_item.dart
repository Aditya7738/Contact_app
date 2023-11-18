import 'package:contact_app/src/models/record.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {

  final Records records;
  final String imagePath;

  const ContactListItem({super.key,
    required this.records,
    required this.imagePath
    });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(records.photo),
          radius: 40,
        ),
        // trailing: Image.asset(imagePath, width: 20.0, height: 30.0,),

        title: Text(records.name, style: TextStyle(fontWeight: FontWeight.bold),),

        subtitle:    Text(records.contact,),

        );


  }
}

