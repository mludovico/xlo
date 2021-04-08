import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/create_bloc.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/helpers/format_field.dart';
import 'package:xlo/models/ad.dart';
import 'package:xlo/screens/create/widgets/hide_phone_widget.dart';
import 'package:xlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Ad ad = Ad();
  CreateBloc createBloc;


  @override
  void initState() {
    super.initState();
    createBloc = CreateBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Anúncio'),
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: StreamBuilder<CreateState>(
          stream: createBloc.outState,
          builder: (context, snapshot) {
            if (snapshot.data == CreateState.LOADING) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Colors.pink
                  ),
                  strokeWidth: 5,
                ),
              );
            }
            return ListView(
              children: [
                ImagesField(
                  onSaved: (images) {
                    ad.images = images;
                  },
                  initialValue: [],
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Título *',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                  ),
                  validator: (text) {
                    if (text.isEmpty) return 'Campo orbigatório';
                    return null;
                  },
                  onSaved: (title) {
                    ad.title = title;
                  },
                ),
                TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Descrição *',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                  ),
                  validator: (text) {
                    if (text.isEmpty) return 'Campo orbigatório';
                    if (text.length < 10) return 'Descrição muito curta';
                    return null;
                  },
                  onSaved: (description) {
                    ad.description = description;
                  },
                ),
                CepField(
                  decoration: InputDecoration(
                    labelText: 'CEP *',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                  ),
                  onSaved: (address) {
                    ad.address = address;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preço *',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    RealInputFormatter(centavos: true),
                  ],
                  validator: (text) {
                    text = text.trim()
                      .replaceAll('.', '')
                      .replaceAll(',', '.');
                    if (text.isEmpty) return 'Campo orbigatório';
                    if (double.tryParse(text) == null)
                      return 'Valor inválido';
                    return null;
                  },
                  onSaved: (price) {
                    ad.price = double.parse(getSanitizedText(price)) / 100;
                  },
                ),
                HidePhoneWidget(
                  initialValue: false,
                  onSaved: (hide) {
                    ad.hidePhone = hide;
                  },
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    child: Text('Enviar'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        print(ad);
                        final bool success = await createBloc.saveAd(ad);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                color: Colors.lightGreenAccent,
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle),
                                    Text('Anúncio inserido com sucesso'),
                                  ],
                                ),
                              ),
                            )
                          );
                          Provider.of<DrawerBloc>(context).setPage(0);
                        }
                      }
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  @override
  void dispose() {
    createBloc.dispose();
    super.dispose();
  }
}
