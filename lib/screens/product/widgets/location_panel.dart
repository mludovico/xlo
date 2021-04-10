import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class LocationPanel extends StatelessWidget {

  final Ad ad;

  LocationPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Text(
            'Localização',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('CEP'),
                  SizedBox(height: 12,),
                  Text('município'),
                  SizedBox(height: 12,),
                  Text('Bairro'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad.address.postalCode),
                    SizedBox(height: 12,),
                    Text(ad.address.city),
                    SizedBox(height: 12,),
                    Text(ad.address.district),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(),
        Row(),
      ],
    );
  }
}
