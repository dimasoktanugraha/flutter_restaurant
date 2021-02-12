import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_all_provider.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';
import 'package:restaurant_app/widget/platform_widget.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantAllProvider>(
      create: (_) => RestaurantAllProvider(apiService: ApiService()),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant'),
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) 
               => SearchScreen()
            ));
          })
        ]
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantAllProvider>(
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
    );
  }
} 