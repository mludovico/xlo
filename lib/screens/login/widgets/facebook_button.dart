import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';

class FacebookButton extends StatelessWidget {

  final LoginBloc loginBloc;

  FacebookButton(this.loginBloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 50,
      child: StreamBuilder<LoginBlocState>(
        stream: loginBloc.outState,
        initialData: LoginBlocState(LoginState.IDLE),
        builder: (context, snapshot) {
          return ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Color(0xFF3b5998).withAlpha(190);
                    } else {
                      return Color(0xFF3b5998);
                    }
                  }
                ),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                ))
            ),
            onPressed: snapshot.data.state == LoginState.LOADING_FACE ? null : () async {
              final bool success = await loginBloc.loginWithFacebook();
              if(success) Navigator.of(context).pop();
            },
            child: snapshot.data.state == LoginState.LOADING_FACE
                ?
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            :
              Text(
                'Entrar com Facebook',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
            ),
          );
        }
      ),
    );
  }
}
