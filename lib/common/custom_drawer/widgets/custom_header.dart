import 'package:flutter/material.dart';
import 'package:xlo/screens/login/login_screen.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginScreen()));
      },
      child: Container(
        height: 100,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Marcelo Ludovico',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'maludovico@gmail.com',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
