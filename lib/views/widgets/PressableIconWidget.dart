import 'package:flutter/material.dart';

class PressableIconWidget extends StatefulWidget {
  PressableIconWidget({Key key, this.iconData, this.label, this.pressedColor = Colors.green, this.onClick, this.iconSize = 10.0})
      : super(key: key);

  final double iconSize;
  final String label;
  final IconData iconData;
  final Color pressedColor;
  final Function onClick;
  final Color baseColor = Colors.white;

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
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.all(0.0),
        height: 35.0,
        child: IconButton(
          icon: Icon(this.widget.iconData),
          onPressed: this.onPress,
          color: this.color,
//          iconSize: this.widget.iconSize,
        )
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
      child: Text(this.widget.label, style: TextStyle(fontSize: 12.0, color: this.color, fontWeight: FontWeight.w800),)
      )
    ], mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,);
  }
}
