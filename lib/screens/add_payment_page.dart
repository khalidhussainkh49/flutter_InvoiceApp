import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_app/models/person_models.dart';
import 'package:invoice_app/store/person_provider.dart';
//import 'package:invoice_app/providers/person_provider.dart';
import 'package:provider/provider.dart';

class AddPaymentPage extends StatefulWidget {
  final Person person;
  
  const AddPaymentPage({required this.person, Key? key}) : super(key: key);

  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  double _amountPaid = 0.0;

  void _savePayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final payment = Payment(
        personId: widget.person.id!,
        amountPaid: _amountPaid,
        paymentDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );

      final personProvider = Provider.of<PersonProvider>(context, listen: false);
      await personProvider.addPayment(payment);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Payment for ${widget.person.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount Paid'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) > widget.person.totalAmount) {
                    return 'Please enter an amount and should not be more than ${widget.person.totalAmount}';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amountPaid = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePayment,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
