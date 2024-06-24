import 'package:flutter/material.dart';
import 'package:invoice_app/models/person_models.dart';
import 'package:invoice_app/store/person_provider.dart';
//import 'package:invoice_app/providers/person_provider.dart';
import 'package:pdf/pdf.dart';
import 'add_payment_page.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PersonDetailsPage extends StatefulWidget {
  final Person person;

  const PersonDetailsPage(this.person, {Key? key}) : super(key: key);

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  @override
  void initState() {
    super.initState();
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    personProvider.loadPayments(widget.person.id!);
  }

  Future<void> _generatePdf(BuildContext context) async {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    final payments = personProvider.payments;
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Payments for ${widget.person.name}', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 16),
            pw.Text(' ${widget.person.address}', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 16),
            pw.Text(' ${widget.person.phoneNumber}', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 16),
            pw.Text(' ${widget.person.building}', style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 16),

            pw.TableHelper.fromTextArray(
              headers: ['Date', 'Amount Paid'],
              data: payments.map((payment) {
                return [
                  payment.paymentDate,
                  payment.amountPaid.toString(),
                ];
              }).toList(),
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name),
      ),

      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        color: Colors.purple,
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${widget.person.name}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Building: ${widget.person.building}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Total Amount: ${widget.person.totalAmount}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                
                ],
              ),
            ],
          ),
        ),
      ),
     Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPaymentPage(person: widget.person)),
              );

              if (result == true) {
                personProvider.loadPayments(widget.person.id!);
              }
            },
            child: const Text('Update Payment'),
          ),
          const SizedBox(width: 16.0), // Add some spacing between the buttons
          ElevatedButton(
            onPressed: () => _generatePdf(context),
            child: const Text('Print Payments'),
          ),
        ],
      ),      Expanded(
        child: ListView.builder(
          itemCount: personProvider.payments.length,
          itemBuilder: (context, index) {
            final payment = personProvider.payments[index];
            return Card (
              child:ListTile(
              title: Text('Date: ${payment.paymentDate}',style:const TextStyle(fontStyle: FontStyle.normal,),),
              subtitle: Text('Amount Paid: ${payment.amountPaid}'),
            ));
          },
        ),
      ),
    ],
  ),
));}

}