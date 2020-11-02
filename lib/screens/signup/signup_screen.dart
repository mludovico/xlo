import 'package:flutter/material.dart';
import 'package:xlo/blocs/signup_bloc.dart';
import 'package:xlo/screens/signup/widgets/password_field.dart';
import 'package:xlo/screens/signup/widgets/widgets/signup_label.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = SignupBloc();
  }

  @override
  void dispose() {
    _signupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Cadastrar'),
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<SignupBlocState>(
          stream: _signupBloc.outState,
          builder: (context, snapshot) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                const SignupLabel(
                  title: 'Apelido',
                  subTitle: 'Como aparecerá em seus anúncios.',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Exemplo: João S.'
                  ),
                  validator: (text){
                    if(text.length < 6)
                      return 'Apelido muito curto';
                    return null;
                  },
                  onSaved: _signupBloc.name,
                  enabled: snapshot.data.state != SignupState.LOADING,
                ),
                SizedBox(height: 10,),
                const SignupLabel(
                  title: 'E-mail',
                  subTitle: 'Enviaremos um e-mail de confirmação.',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                  ),
                  validator: (text){
                    if(text.length < 6 || !text.contains('@'))
                      return 'Email inválido';
                    return null;
                  },
                  onSaved: _signupBloc.email,
                  enabled: snapshot.data.state != SignupState.LOADING,
                ),
                SizedBox(height: 10,),
                const SignupLabel(
                  title: 'Senha',
                  subTitle: 'Use letras, números e caracteres especiais.',
                ),
                PasswordField(
                  onSaved: _signupBloc.password,
                  enabled: snapshot.data.state != SignupState.LOADING,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  height: 50,
                  child: RaisedButton(
                    color: Colors.pink,
                    child: snapshot.data.state == SignupState.LOADING
                      ?
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                      :
                    Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    disabledColor: Colors.pink.withAlpha(150),
                    onPressed: snapshot.data.state == SignupState.LOADING ? null : _signUp,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tem uma conta? ',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void _signUp(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      _signupBloc.signUp();
    }
  }
}
