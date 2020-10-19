import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {

  final IconData iconData;
  final String label;
  final Function onTap;
  final bool highlighted;

  IconTile({this.iconData, this.label, this.onTap, this.highlighted});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: highlighted ? Colors.orange : Colors.grey[700],
      ),
      title: Text(
        label,
        style: TextStyle(
          color: highlighted ? Colors.orange : Colors.grey[700]
        ),
      ),
      onTap: onTap,
    );
  }
}
