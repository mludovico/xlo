import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final bool enabled;

  PasswordField({this.onSaved, this.enabled});
  @override
  Widget build(BuildContext context) {
    
    Widget _buildBar(int n, String pass){
      final int level = _calcScore(pass);
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5),),
            //border: Border.all(color: n >= level ? _getColor(level) : Colors.transparent),
            color: n <= level ? _getColor(level) : Colors.transparent
          ),
        ),
      );
    }
    return FormField<String>(
      initialValue: '',
      validator: (text){
        if(text.isEmpty || _calcScore(text) < 2)
          return 'Senha inválida';
        return null;
      },
      builder: (state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: state.didChange,
              enabled: enabled,
            ),
            if(state.value.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 8,
              child: Row(
                children: [
                  _buildBar(0, state.value),
                  _buildBar(1, state.value),
                  _buildBar(2, state.value),
                  _buildBar(3, state.value),
                ],
              ),
            ),
            if(state.value.isNotEmpty || state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 10),
              child: Text(
                state.hasError ? state.errorText : _getText(_calcScore(state.value)),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: _getColor(_calcScore(state.value)),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  int _calcScore(String text){
    int _score = 0;
    if(text.length > 8)
      _score++;
    if(text.contains(RegExp(r"[0-9]")))
      _score++;
    if(text.contains(RegExp(r"[A-Z]")))
      _score++;
    return _score;
  }

  Color _getColor(int level){
    Color color;
    switch(level){
      case 0:
        color = Colors.red;
        break;
      case 1:
        color = Colors.deepOrange;
        break;
      case 2:
        color = Colors.amber;
        break;
      case 3:
        color = Colors.green;
        break;
    }
    return color;
  }

  String _getText(int level) {
    String text;
    switch(level) {
      case 0:
        text = 'Senha muito fraca';
        break;
      case 1:
        text = 'Senha razoavelmente fraca';
        break;
      case 2:
        text = 'Senha razoavelmente forte';
        break;
      case 3:
        text = 'Senha forte';
        break;
    }
    return text;
  }
}
