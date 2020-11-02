import 'dart:async';

import 'package:xlo/blocs/login/field_state.dart';

class Loginvalidator{
  final StreamTransformer<String, FieldState> emailValidator =
    StreamTransformer<String, FieldState>.fromHandlers(
      handleData: (email, sink){
        const Pattern pattern =
            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
        final RegExp regex = RegExp(pattern);
        if(email.isEmpty)
          sink.add(FieldState(error: 'Campo obrigatório',));
        else if(!regex.hasMatch(email))
          sink.add(FieldState(error: 'E-mail inválido'));
        else
          sink.add(FieldState());
      }
    );

  final StreamTransformer<String, FieldState> passwordValidator =
      StreamTransformer<String, FieldState>.fromHandlers(
        handleData: (password, sink){
          if(password.isEmpty)
            sink.add(FieldState(error: 'Campo obrigatório'));
          else
            sink.add(FieldState());
        }
      );
}