import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawerLabel extends StatelessWidget {
  final String? title;
  final void Function()? method;
  final Icon? icon;

  const CustomDrawerLabel({super.key, this.method, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: method,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Constants.globalColorNeutral20,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 30,
            width: 30,
            child: icon,
          ),
          SizedBox(width: 10),
          Text(title.toString(), style: Constants.typographyBlackBoldM),
          Spacer(),
          Icon(Icons.arrow_forward_ios_sharp),
        ],
      ),
    );
  }
}
