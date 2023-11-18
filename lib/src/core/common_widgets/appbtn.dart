
import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  final String buttonTitle;
  final Function onPressed;

  const AppBtn({super.key, required this.buttonTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(onPressed: (){
        onPressed();
      },
          child: Text(buttonTitle)
      ),
    );
  }
}
