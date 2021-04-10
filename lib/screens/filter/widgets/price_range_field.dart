import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/helpers/format_field.dart';
import 'package:xlo/models/filter.dart';

class PriceRangeField extends StatelessWidget {

  final Filter filter;
  PriceRangeField({this.filter});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Min',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              RealInputFormatter(centavos: false),
            ],
            initialValue: filter.minPrice?.toString(),
            onSaved: (value){
              if(value.isEmpty)
                filter.minPrice = null;
              else
                filter.minPrice = int.tryParse(getSanitizedText(value));
            },
            validator: (value){
              if(value.isNotEmpty && int.tryParse(getSanitizedText(value)) == null)
                return 'Valor inválido';
              return null;
            },
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Max',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              RealInputFormatter(centavos: false),
            ],
            initialValue: filter.maxPrice?.toString(),
            onSaved: (value){
              if(value.isEmpty)
                filter.maxPrice = null;
              else
                filter.maxPrice = int.tryParse(getSanitizedText(value));
            },
            validator: (value){
              if(value.isNotEmpty && int.tryParse(getSanitizedText(value)) == null)
                return 'Valor inválido';
              return null;
            },
          ),
        )
      ],
    );
  }
}
