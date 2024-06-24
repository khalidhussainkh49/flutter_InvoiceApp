import 'package:flutter/material.dart';
import 'package:invoice_app/models/person_models.dart';

class AddPaymentPageTest extends StatelessWidget {
  final Person person;

  const AddPaymentPageTest({required this.person, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Payment for ${person.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Payment Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle saving the payment here
            Navigator.pop(context, true);
          },
          child: Text('Save Payment'),
        ),
      ],
    );
  }
}
