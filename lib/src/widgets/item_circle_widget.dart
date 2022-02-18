import 'package:cinema_app/src/data/data.dart';
import 'package:flutter/material.dart';

class ItemCircleWidget extends StatefulWidget {
  const ItemCircleWidget({
    Key key,
    @required this.i,
    @required this.j,
  }) : super(key: key);

  final int i;
  final int j;

  @override
  State<ItemCircleWidget> createState() => _ItemCircleWidgetState();
}

class _ItemCircleWidgetState extends State<ItemCircleWidget> {
  bool bandera = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (bandera == true) {
            bandera = false;
            asientos3[widget.i][widget.j] = 2;
          } else {
            bandera = true;
            asientos3[widget.i][widget.j] = 1;
          }
        });
      },
      child: Padding(
        padding: widget.j <= (asientos3.length / 2)
            ? EdgeInsets.only(top: widget.j.toDouble() * 1) // 1!
            : EdgeInsets.only(
                bottom: widget.j.toDouble() * 1.5 - 21.5, top: 18),
        child: Container(
          height: 4.5,
          width: 4.5,
          decoration: BoxDecoration(
            color: asientos3[widget.i][widget.j] == 0
                ? Colors.red
                : asientos3[widget.i][widget.j] == 1
                    ? Colors.grey[400]
                    : asientos3[widget.i][widget.j] == 2
                        ? Colors.blue
                        : asientos3[widget.i][widget.j] == 5
                            ? Colors.green
                            : Colors.white,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(top: 2, right: 2),
        ),
      ),
    );
  }
}
