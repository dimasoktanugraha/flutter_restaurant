import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant.dart';

RestaurantAllResponse restaurantResponseFromJson(String str) => RestaurantAllResponse.fromJson(json.decode(str));

String restaurantResponseToJson(RestaurantAllResponse data) => json.encode(data.toJson());

class RestaurantAllResponse {
    RestaurantAllResponse({
        this.error,
        this.message,
        this.count,
        this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<Restaurant> restaurants;

    factory RestaurantAllResponse.fromJson(Map<String, dynamic> json) => RestaurantAllResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}