import 'dart:convert';

RestaurantReviewResponse restaurantReviewResponseFromJson(String str) => RestaurantReviewResponse.fromJson(json.decode(str));

String restaurantReviewResponseToJson(RestaurantReviewResponse data) => json.encode(data.toJson());

class RestaurantReviewResponse {
    RestaurantReviewResponse({
        this.error,
        this.message,
        this.customerReviews,
    });

    bool error;
    String message;
    List<CustomerReview> customerReviews;

    factory RestaurantReviewResponse.fromJson(Map<String, dynamic> json) => RestaurantReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class CustomerReview {
    CustomerReview({
        this.name,
        this.review,
        this.date,
    });

    String name;
    String review;
    String date;

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}
