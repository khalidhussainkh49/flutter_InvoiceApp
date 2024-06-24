class Person {
  int? id;
  String name;
  String building;
  String address;
  String phoneNumber;
  double totalAmount;
  double amountPaid;

  Person({
    this.id,
    required this.name,
    required this.building,
    required this.phoneNumber,
    required this.address,
    required this.totalAmount,
    required this.amountPaid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'building': building,
      'address': address,
      'phoneNumber': phoneNumber,
      'totalAmount': totalAmount,
      'amountPaid': amountPaid,

    };
  }
}

class Payment {
  int? id;
  int personId;
  double amountPaid;
  String paymentDate;

  Payment({
    this.id,
    required this.personId,
    required this.amountPaid,
    required this.paymentDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'personId': personId,
      'amountPaid': amountPaid,
      'paymentDate': paymentDate,
    };
  }
}
