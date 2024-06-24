import 'package:flutter/material.dart';
import 'package:invoice_app/screens/add_person.dart';
import 'package:invoice_app/screens/person_details.dart';
import 'package:invoice_app/store/person_provider.dart';
import 'package:provider/provider.dart';

class PersonListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: personProvider.persons.length,
              itemBuilder: (context, index) {
                final person = personProvider.persons[index];
                return Card(
                  elevation: 10.0,
                  child: ListTile(
                    title: Text(
                      person.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    subtitle: Text('Total Amount: ${person.totalAmount}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonDetailsPage(person),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPersonPage()),
          );

          if (result == true) {
            personProvider.loadPersons();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
