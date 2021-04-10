import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/screens/account_edit/widgets/type_selector.dart';

class AccountEditScreen extends StatefulWidget {

  @override
  _AccountEditScreenState createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {

  final User _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TypeSelector(
            initialValue: _user.userType,
            onSaved: (value) {

            }
          ),
          TextFormField(
            initialValue: _user.name,
            decoration: InputDecoration(
              labelText: 'Nome *',
              contentPadding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            ),
            validator: (name) {
              if (name.isEmpty || name.length < 6) return 'Nome inválido';
              return null;
            },
            onSaved: (name) {

            },
          ),
          TextFormField(
            initialValue: _user.phone,
            decoration: InputDecoration(
              labelText: 'Telefone *',
              contentPadding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              TelefoneInputFormatter()
            ],
            validator: (phone) {
              if (phone.isEmpty || phone.length < 15) return 'Telefone inválido';
              return null;
            },
            onSaved: (phone) {

            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nova senha',
              contentPadding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            ),
            obscureText: true,
            validator: (password) {
              if (password.isNotEmpty && password.length < 6)
                return 'Senha muito curta';
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Repetir nova senha',
              contentPadding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            ),
            obscureText: true,
            validator: (password) {
              if (password.isNotEmpty && password.length < 6)
                return 'Senha muito curta';
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          GestureDetector(
            child: Container(
              height: 38,
              margin: const EdgeInsets.only(top: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.all(Radius.circular(19)),
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 38,
              margin: const EdgeInsets.only(top: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(19)),
              ),
              child: Text(
                'Sair',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
