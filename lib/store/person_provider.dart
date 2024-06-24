import 'package:flutter/material.dart';
import 'package:invoice_app/models/person_models.dart';
import 'package:invoice_app/utils/database_helpers.dart';

class PersonProvider with ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Person> _persons = [];
  List<Payment> _payments = [];

  List<Person> get persons => _persons;
  List<Payment> get payments => _payments;

  PersonProvider() {
    loadPersons();
  }

  Future<void> loadPersons() async {
    _persons = await dbHelper.getPersons();
    notifyListeners();
  }

  Future<void> loadPayments(int personId) async {
    _payments = await dbHelper.getPaymentsByPersonId(personId);
    notifyListeners();
  }

  Future<void> addPerson(Person person) async {
    await dbHelper.insertPerson(person);
    await loadPersons();
  }

  Future<void> addPayment(Payment payment) async {
    await dbHelper.insertPayment(payment);
    await updatePersonTotalAmount(payment.personId, payment.amountPaid);
    await loadPayments(payment.personId);
  }

  Future<void> updatePersonTotalAmount(int personId, double amountPaid) async {
    final personIndex = _persons.indexWhere((person) => person.id == personId);
    if (personIndex != -1) {
      _persons[personIndex].totalAmount -= amountPaid;
      await dbHelper.updatePerson(_persons[personIndex]);
      notifyListeners();
    }
  }
}
