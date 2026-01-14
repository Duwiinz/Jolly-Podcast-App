class SubscriptionDetails {
  final String title;
  final double amount;

  SubscriptionDetails({required this.title, required this.amount});

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    return SubscriptionDetails(
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
    );
  }
}

class Subscription {
  final int id;
  final String statusCode;
  final SubscriptionDetails details;

  Subscription({required this.id, required this.statusCode, required this.details});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      statusCode: json['statusCode'],
      details: SubscriptionDetails.fromJson(json['details']),
    );
  }
}
