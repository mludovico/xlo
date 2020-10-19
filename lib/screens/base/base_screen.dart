import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/screens/home/home_screen.dart';

class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final PageController _pageController = PageController();
  StreamSubscription _drawerSubscription;
  DrawerBloc _drawerBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DrawerBloc drawerBloc = Provider.of<DrawerBloc>(context);
    if(_drawerBloc != drawerBloc)
      _drawerBloc = drawerBloc;
    _drawerSubscription?.cancel();
    _drawerSubscription = _drawerBloc.outPage.listen((page) {
      _pageController.jumpToPage(page??0);
    });
  }

  @override
  void dispose() {
    _drawerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomeScreen(),
        Container(color: Colors.green,),
        Container(color: Colors.red,),
        Container(color: Colors.green,),
        Container(color: Colors.red,),
      ],
    );
  }
}
