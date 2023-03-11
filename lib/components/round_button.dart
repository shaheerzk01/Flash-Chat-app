import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({@required this.color,this.btittle, @required this.onPressed}){}

    Color? color = Colors.lightBlueAccent;
    String? btittle;
    late VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 42.0,
          child: Text(
            '$btittle',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
