import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';

class SearchScreen extends StatefulWidget{
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {  
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _){
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search Restaurant',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none
                ),
                onChanged: (value){
                    state.searchRestaurat(value);
                },
              ),
            ),
            body: Consumer<RestaurantSearchProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  return ListView(
                    children: state.result.restaurants.map((data) {
                      return CardRestaurant(restaurant: data,);
                    }).toList(),
                  );
                } else if (state.state == ResultState.NoData) {
                  return Center(child: Text(state.message));
                } else if (state.state == ResultState.Error) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          );
        },
      ),
    );
  }
}



