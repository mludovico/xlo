import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/account_edit/account_edit_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text('Minha conta'),
        centerTitle: false,
        actions: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white)
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AccountEditScreen())
              );
            },
            child: Text(
              'EDITAR',
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Marcelo Ludovico',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Meus anúncios',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {

            },
          ),
          ListTile(
            title: Text(
              'Favoritos',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
