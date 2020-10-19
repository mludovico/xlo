import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/common/custom_drawer/widgets/icons_tile.dart';

class IconSection extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final DrawerBloc _drawerBloc = Provider.of<DrawerBloc>(context);
    void _setPage(int page){
      Navigator.of(context).pop();
      _drawerBloc.setPage(page);
    }
    return Expanded(
      child: StreamBuilder<int>(
        stream: _drawerBloc.outPage,
        builder: (context, snapshot) {
          return ListView(
            children: [
              IconTile(
                iconData: Icons.list,
                label: 'Anúncios',
                highlighted: snapshot.data == 0,
                onTap: (){
                  _setPage(0);
                },
              ),
              IconTile(
                iconData: Icons.edit,
                label: 'Inserir Anúncio',
                highlighted: snapshot.data == 1,
                onTap: (){
                  _setPage(1);
                },
              ),
              IconTile(
                iconData: Icons.chat,
                label: 'Chat',
                highlighted: snapshot.data == 2,
                onTap: (){
                  _setPage(2);
                },
              ),
              IconTile(
                iconData: Icons.favorite,
                label: 'Favoritos',
                highlighted: snapshot.data == 3,
                onTap: (){
                  _setPage(3);
                },
              ),
              IconTile(
                iconData: Icons.person,
                label: 'Minha conta',
                highlighted: snapshot.data == 4,
                onTap: (){
                  _setPage(4);
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
