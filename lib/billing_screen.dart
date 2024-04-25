import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  List<Invoice> invoices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Invoice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 16),
            // const TextField(
            //   decoration: InputDecoration(labelText: 'Customer Name'),
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Implement logic to generate PDF invoice
                Invoice newInvoice = generateInvoice();
                final filePath = await generatePdf(newInvoice);
                setState(() {
                  invoices.add(newInvoice);
                });
                // Navigate to PdfScreen with the generated file path
                // ignore: use_build_context_synchronously
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PdfScreen(filePath: filePath),
                //   ),
                // );
              },
              child: const Text('Generate Invoice'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Manage Invoices',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  return InvoiceListItem(invoice: invoices[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Invoice generateInvoice() {
    return Invoice(
      customerName: 'John Doe',
      items: [
        InvoiceItem(name: 'Item 1', quantity: 2, price: 20),
        InvoiceItem(name: 'Item 2', quantity: 3, price: 15),
      ],
    );
  }

  Future<String> generatePdf(Invoice invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => InvoicePdf(invoice: invoice),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final uniqueFileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final filePath = '${directory.path}/$uniqueFileName';
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());

    return filePath;
  }
}

class Invoice {
  final String customerName;
  final List<InvoiceItem> items;

  Invoice({required this.customerName, required this.items});
}

class InvoiceItem {
  final String name;
  final int quantity;
  final double price;

  InvoiceItem({required this.name, required this.quantity, required this.price});
}

class InvoicePdf extends pw.StatelessWidget {
  final Invoice invoice;

  InvoicePdf({Key? key, required this.invoice}) : super();

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Customer: ${invoice.customerName}', 
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 30
            )
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Invoice Items:', 
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 18
            )
          ),
          for (var item in invoice.items)
            pw.Text(
              '${item.name} - Quantity: ${item.quantity}, Price: \$${item.price}',
              style: const pw.TextStyle(
                fontSize: 18
              )
            ),
        ],
      ),
    );
  }
}

class InvoiceListItem extends StatelessWidget {
  final Invoice invoice;

  const InvoiceListItem({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Customer: ${invoice.customerName}'),
      subtitle: Text('Total: \$${calculateTotal(invoice)}'),
      onTap: () async {
        // Generate the PDF and get the file path
        final filePath = await _BillingScreenState().generatePdf(invoice);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfScreen(filePath: filePath),
          ),
        );
      },
    );
  }

  double calculateTotal(Invoice invoice) {
    return invoice.items.fold(0, (sum, item) => sum + item.quantity * item.price);
  }
}


class PdfScreen extends StatelessWidget {
  final String filePath;

  const PdfScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF View'),
      ),
      body: PDFView(
        filePath: filePath,
        autoSpacing: true,
        pageSnap: true,
        swipeHorizontal: true,
        onPageError: (value, d){
          print("Error");
        },
        onError: (d){
          print(d);
        },
      ),
    );
  }
}
