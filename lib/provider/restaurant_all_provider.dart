import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_all.dart';

class RestaurantAllProvider extends ChangeNotifier{
  final ApiService apiService;

  RestaurantAllProvider({@required this.apiService}){
    _fetchAllRestaurant();
  }

  RestaurantAllResponse _restaurantResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
 
  RestaurantAllResponse get result => _restaurantResult;
 
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getAllRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Koneksi Internet Bermasalah';
    }
  }
}