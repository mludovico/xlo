import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class BottomBar extends StatelessWidget {

  final Ad ad;

  BottomBar(this.ad);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 26),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: const BorderRadius.all(
                Radius.circular(19),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    'Ligar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                VerticalDivider(
                  //color: Colors.pink,
                  indent: 5,
                  endIndent: 5,
                  thickness: 1,
                ),
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 38,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(249, 249, 249, 1),
              border: Border(top: BorderSide(color: Colors.grey[400]))
            ),
            alignment: Alignment.center,
            child: Text(
              'Marcelo Ludovico (anunciante)',
              style: TextStyle(
                fontWeight: FontWeight.w300
              ),
            ),
          ),
        ],
      ),
    );
  }
}
