import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;
  OptionTile(
      {required this.optionSelected,
      required this.correctAnswer,
      required this.description,
      required this.option});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.description == widget.optionSelected
                      ? widget.description == widget.correctAnswer
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey,
                  width: 1.5),
              color: widget.optionSelected == widget.description
                  ? widget.description == widget.correctAnswer
                  ? Colors.green.withOpacity(0.7)
                  : Colors.red.withOpacity(0.7)
                  : Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.option,
              style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? Colors.white
                      : Colors.grey),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
final String text;
final int number;

NoOfQuestionTile({required this.text, required this.number});

@override
_NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}