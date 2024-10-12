class AddExpenseReq {
  String? id;
  String? amount;
  String? date;
  String? category;
  String? description;

  AddExpenseReq({
    this.id,
    this.amount,
    this.date,
    this.category,
    this.description,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['date'] = date;
    data['category'] = category;
    data['description'] = description;
    return data;
  }
}
