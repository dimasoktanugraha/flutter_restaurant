import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/widget/card_menu.dart';
import 'package:restaurant_app/widget/card_reviews.dart';

class DetailScreen extends StatelessWidget {

  final String id;

  DetailScreen({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _){
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return _detailUI(state.result.restaurant, context, state);
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          }
        )
      ),
    );
  }
}      
          
Widget _detailUI(Restaurant restaurant, BuildContext context, RestaurantDetailProvider state) {
  
  final _textController = TextEditingController();

  
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 180,  
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                fit: BoxFit.cover,
                color: Color(0xffffffff).withOpacity(1.0),
                colorBlendMode: BlendMode.color,
                ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 5)
                ],
              ),
            ),
            Center(
              child: Container(
                width: 200,
                height: 200,
                margin: EdgeInsets.only(top: 50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                    fit: BoxFit.cover,),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 5)
                  ],
                ),
              )
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          child: Text(
            restaurant.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Row(
            children: [
              Icon(
                Icons.pin_drop, 
                color: Colors.black,
                size: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  restaurant.city,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black),
                  ),
                ),
              ],
            ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 20.0),
          child: Row(
            children: [
              Icon(
                Icons.map_sharp, 
                color: Colors.grey,
                size: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  restaurant.address,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black),
                  ),
                ),
              ],
            ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 20.0),
          child: Row(
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
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text(
            "Description",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: ReadMoreText(
            restaurant.description,
            trimLines: 4,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text(
            "Food",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: restaurant.menus.foods.length,
            itemBuilder: (context, index) {
              var food = restaurant.menus.foods[index];
              return CardMenu(menu: food);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text(
            "Drink",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                var drink = restaurant.menus.drinks[index];
                return CardMenu(menu: drink);
              },
            ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text(
            "Review",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
          child: TextField(
            controller: _textController,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5, 
            expands: false,
            decoration: InputDecoration(
              hintText: "Review",
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(5.0 ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text("Send"),
              onPressed: (){
                state.setReview(_textController.value.text, restaurant.id);
                // Toast.show(_textController.value.text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              }
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: restaurant.customerReviews.length,
          itemBuilder: (context, index) {
            var review = restaurant.customerReviews[index];
            return CardReviews(customerReview: review);
          },
        )
      ],
    ),
  );
}

  
