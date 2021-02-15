import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class RestaurantSearchProvider extends ChangeNotifier{
  final ApiService apiService;

  RestaurantSearchProvider({@required this.apiService}){
    _fetchSearchRestaurant("");
  }

  RestaurantSearchResponse _restaurantResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
 
  RestaurantSearchResponse get result => _restaurantResult;
 
  ResultState get state => _state;

  void searchRestaurat(String data){
    _fetchSearchRestaurant(data);
  }

  Future<dynamic> _fetchSearchRestaurant(String data) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(data);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Restaurant tidak ditemukan';
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