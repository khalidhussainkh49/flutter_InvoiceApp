import 'package:flutter/material.dart';
import 'package:invoice_app/models/person_models.dart';
import 'package:invoice_app/store/person_provider.dart';
//import 'package:invoice_app/providers/person_provider.dart';
import 'package:provider/provider.dart';

class AddPersonPage extends StatefulWidget {
  @override
  _AddPersonPageState createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _building = '';
  double _totalAmount = 0.0;
  double _amountPaid = 0.0;
  String _address='';
  String _phoneNumber = '';

  void _savePerson() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newPerson = Person(name: _name, building: _building, totalAmount: _totalAmount, amountPaid: _amountPaid, address: _address, phoneNumber: _phoneNumber);
      final personProvider = Provider.of<PersonProvider>(context, listen: false);
      await personProvider.addPerson(newPerson);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),

               TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a  address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),

               TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Phone Number';
                  }
                  return null;
                },
                onSaved: (value) {
                 _phoneNumber  = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Building Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a building type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _building = value!;
                },
              ),

                           
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a total amount';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalAmount = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePerson,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
