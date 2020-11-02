import 'package:flutter/material.dart';
import 'package:xlo/models/filter.dart';
import 'package:xlo/screens/filter/widgets/animated_button.dart';
import 'package:xlo/screens/filter/widgets/order_by_field.dart';
import 'package:xlo/screens/filter/widgets/price_range_field.dart';
import 'package:xlo/screens/filter/widgets/section_title.dart';
import 'package:xlo/screens/filter/widgets/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  Filter _filter = Filter(
    search: 'bike',
    orderBy: OrderBy.PRICE,
    maxPrice: 50,
    minPrice: 10,
    vendorType: VENDOR_TYPE_PROFESSIONAL
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Filtrar busca'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                const SectionTitle(title: 'Ordenar por',),
                OrderByField(
                  initialValue: _filter.orderBy,
                  onSaved: (value){
                    _filter.orderBy = value;
                  },
                ),
                const SectionTitle(title: 'Preço (R\$)',),
                PriceRangeField(
                  filter: _filter,
                ),
                const SectionTitle(title: 'Tipo de anunciante',),
                VendorTypeField(
                  initialValue: _filter.vendorType,
                  onSaved: (value){
                    _filter.vendorType = value;
                  },
                ),
              ],
            ),
          ),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: (){
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                if(_filter.maxPrice != null && _filter.minPrice != null && _filter.minPrice > _filter.maxPrice){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Faixa de preço inválida'),
                      backgroundColor: Colors.blue,
                    )
                  );
                  return;
                }
              }
              //Salvar e pesquisar
            },
          ),
        ]
      ),
    );
  }
}
