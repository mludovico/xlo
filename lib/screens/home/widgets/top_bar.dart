import 'package:flutter/material.dart';
import 'package:xlo/screens/filter/filter_screen.dart';
import 'package:xlo/screens/home/widgets/bar_button.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            blurRadius: 20,
            offset: Offset(0, 2),
          ),
        ]
      ),
      child: Row(
        children: [
          BarButton(
            label: 'Categorias',
            boxDecoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            width: 3,
            height: 50,
            color: Colors.grey[400],
          ),
          BarButton(
            label: 'Filtros',
            boxDecoration: BoxDecoration(
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FilterScreen())
            ),
          ),
        ],
      ),
    );
  }
}
