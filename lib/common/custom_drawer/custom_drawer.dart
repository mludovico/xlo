import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/widgets/custom_header.dart';
import 'package:xlo/common/custom_drawer/widgets/icon_section.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            CustomHeader(),
            IconSection(),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
