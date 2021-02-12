import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_screen.dart';

class CardRestaurant extends StatelessWidget{
  final Restaurant restaurant;

  const CardRestaurant({Key key, this.restaurant}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(id: restaurant.id);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                    fit: BoxFit.cover,),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 5)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        restaurant.city,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 24.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              restaurant.rating.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }}