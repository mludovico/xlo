import 'package:flutter/material.dart';
import 'package:xlo/models/user.dart';

class TypeSelector extends StatelessWidget {

  final UserType initialValue;
  final FormFieldSetter<UserType> onSaved;

  const TypeSelector({this.initialValue, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: initialValue,
      onSaved: onSaved,
      builder: (state) => Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text('Prticular'),
                Radio<UserType>(
                  value: UserType.PARTICULAR,
                  groupValue: state.value,
                  onChanged: state.didChange,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('Profissional'),
                Radio<UserType>(
                  value: UserType.PROFESSIONAL,
                  groupValue: state.value,
                  onChanged: state.didChange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
