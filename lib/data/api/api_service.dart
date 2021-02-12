import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_all.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantAllResponse> getAllRestaurant() async {
    final response = await http.get(_baseUrl +
        "list");
    if (response.statusCode == 200) {
      return RestaurantAllResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(String id) async {
    final response = await http.get(_baseUrl +
        "detail/$id");
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String data) async {
    final response = await http.get(_baseUrl +
        "search?q=$data");
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantReviewResponse> postReview(String review, String id) async {
    final response = await http.post(_baseUrl +
        "review",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'name': 'Dimas',
          'review': review
        }),);
    if (response.statusCode == 200) {
      return RestaurantReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}