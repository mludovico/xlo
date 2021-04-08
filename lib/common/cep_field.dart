import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/blocs/cep_bloc.dart';
import 'package:xlo/models/address.dart';

class CepField extends StatefulWidget {

  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;

  CepField({this.decoration, this.onSaved});

  @override
  _CepFieldState createState() => _CepFieldState(
      decoration: decoration,
      onSaved: onSaved,
  );
}

class _CepFieldState extends State<CepField> {

  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;
  CepBloc cepBloc;

  _CepFieldState({this.decoration, this.onSaved});


  @override
  void initState() {
    super.initState();
    cepBloc = CepBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
      initialData: CepBlocState(
        cepFieldState: CepFieldState.INITIALIZING,
      ),
      stream: cepBloc.outCep,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.cepFieldState == CepFieldState.INITIALIZING) {
          return Container();
        }
        return Column(
          children: [
            TextFormField(
              initialValue: snapshot.data.cep,
              decoration: decoration,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                CepInputFormatter(),
              ],
              onChanged: cepBloc.onChanged,
              onSaved: (cep) {
                print(snapshot.data.address);
                onSaved(snapshot.data.address);
              },
              validator: (cep) {
                switch (snapshot.data.cepFieldState) {
                  case CepFieldState.INCOMPLETE:
                    return 'Campo obrigatório';
                  case CepFieldState.INVALID:
                    return 'Cep inválido';
                  case CepFieldState.VALID:
                  case CepFieldState.INITIALIZING:
                  default:
                    return null;
                }
              },
            ),
            snapshot.data.cepFieldState == CepFieldState.VALID ?
              Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                color: Colors.orange,
                alignment: Alignment.center,
                child: Text(
                  'Localização: ${snapshot.data.address.district} - '
                  '${snapshot.data.address.city} - ${snapshot.data.address.uf}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ) : Container()
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    cepBloc.dispose();
    super.dispose();
  }
}
