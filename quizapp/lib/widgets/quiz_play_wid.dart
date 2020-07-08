import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, descriptions, correctAnswer, optionselected;
  OptionTile(
      {@required this.option,
      @required this.descriptions,
      @required this.correctAnswer,
      @required this.optionselected});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.descriptions == widget.optionselected
                      ? widget.optionselected == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey,
                  width: 1.5),
              borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          child: Text(
            "${widget.option}",
            style: TextStyle(
                color: widget.optionselected == widget.descriptions
                    ? widget.correctAnswer == widget.optionselected
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red
                    : Colors.grey,
                fontSize: 25),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          widget.descriptions,
          style: TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ],
    ));
  }
}
