import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
        TextSpan(
            text: 'Maker',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue)),
      ],
    ),
  );
}

Widget bluebutton({BuildContext context, String label, button}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    height: 50,
    alignment: Alignment.center,
    width: button != null ? button : MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
