class ExpenseResponse {
  final String id;
  final String amount;
  final String date;
  final String category;
  final String description;

  ExpenseResponse({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.description,
  });

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
      id: json['id'],
      amount: json['amount'],
      date: json['date'],
      category: json['category'],
      description: json['description'],
    );
  }
}
