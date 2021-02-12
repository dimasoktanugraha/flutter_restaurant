import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class CardMenu extends StatelessWidget{

  final Category menu;

  const CardMenu({Key key, this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(4.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Text(menu.name,
                textAlign: TextAlign.center,),
              )
            )
          ),
        ),
    );
  }
}