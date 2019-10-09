import 'package:flutter/material.dart';

class PressableIconWidget extends StatefulWidget {
  PressableIconWidget({Key key, this.iconData, this.label, this.pressedColor = Colors.green, this.onClick})
      : super(key: key);

  String label;
  IconData iconData;
  Color pressedColor;
  Function onClick;
  Color baseColor = Colors.white;

  @override
  _PressableIconWidgetState createState() => _PressableIconWidgetState();
}

class _PressableIconWidgetState extends State<PressableIconWidget> {
  Color color = Colors.white;
  bool toggled = false;

  onPress() {
    setState(() {
      color = !toggled ? this.widget.pressedColor : this.widget.baseColor;
    });
    this.widget.onClick();
    toggled = !toggled;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      IconButton(
        icon: Icon(this.widget.iconData),
        onPressed: this.onPress,
        color: this.color,
      ),
      Text(this.widget.label, style: TextStyle(fontSize: 12.0, color: this.color, fontWeight: FontWeight.w800),)
    ]);
  }
}
