import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  String? email;
  String? id;
  String? name;
  int? age;
  int? number;
  double? balance;
  Data({
    this.id,
    this.email,
    this.name,
    this.age,
    this.number,
    this.balance,
  });

  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'number': number,
      'email': email,
      'balance': balance,
    };
  }

  factory Data.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Data(
      id: doc.id,
      email: data['email'],
      name: data['name'],
      age: data['age'],
      number: data['number'],
      balance: data['balance'],
    );
  }
}
