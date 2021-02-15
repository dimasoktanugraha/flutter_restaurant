import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/common/result_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';

class RestaurantDetailProvider extends ChangeNotifier{
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({@required this.apiService, @required this.id}){
    _fetchDetail(id);
  }

  RestaurantDetailResponse _detailResult;
  RestaurantReviewResponse _reviewResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
 
  RestaurantDetailResponse get result => _detailResult;
 
  ResultState get state => _state;

  Future<dynamic> _fetchDetail(String id) async{
      try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(id);
      if (restaurant.restaurant==null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Koneksi Internet Bermasalah';
    } 
  }

  void setReview(String review, String id){
    _postReview(review, id);
  }

  Future<dynamic> _postReview(String reviewText, String id) async{
      try {
      _state = ResultState.Loading;
      notifyListeners();
      final review = await apiService.postReview(reviewText, id);
      if (review.customerReviews.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        _fetchDetail(id);
        return _reviewResult = review;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Koneksi Internet Bermasalah';
    } 
  }
}