import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaxInvoiceScreen extends StatefulWidget {
  @override
  _TaxInvoiceScreenState createState() => _TaxInvoiceScreenState();
}

class _TaxInvoiceScreenState extends State<TaxInvoiceScreen> {
  String paymentMode = 'Credit';
  String customer = 'Brutal Clothing';
  String shippingAddress = 'Store Address';
  DateTime? paymentDueDate;
  String placeOfSupply = '';

  Future<void> generateTaxInvoice() async {
    const url = 'http://3.108.137.111:4000/stocks/v1/b2b/tax_invoice';
    const headers = {
      'Content-Type': 'application/json',
      'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJxcGlkIjo0OSwic2Vzc2lvbl9pZCI6NjcsImlhdCI6MTcyMDcxMTIxOCwiZXhwIjoxNzIyMDA3MjE4LCJpc3MiOiJxdWlja3ByaXNtIn0.MPeQXP82-8kKSWB1XzLNOzhXfa_y3lyUfqo7Mfyut9E', // Replace with your actual token
    };
    final body = json.encode({
      "business_id": 7,
      "shop_id": 12,
      "created_by": 5,
      "vendor_id": 4,
      "invoice_number": "KLSFS78",
      "purchase_order_no": "113reu",
      "date": "2024-06-07",
      "payment_due_date": "2024-08-07",
      "place_of_supply": "indira market",
      "payment_terms": "pay on time",
      "bank_id": 5,
      "discount": 500,
      "billing_address_id": 7,
      "shipping_address_id": 7,
      "seller_signatory": "Sanjeev",
      "cgst_sgst": 7.5,
      "igst": 3.5,
      "sub_total": 3000,
      "total_amount": 5000,
      "taxable_amount": 200,
      "other_charges": 50,
      "tcs": 3.5,
      "tds": 3.5,
      "hsn_sac": 11055,
      "tax_invoice_status": "due",
      "proforma_invoice_id": 7,
      "delivery_challan_id": 1,
      "items": [
        {
          "item_id": 10,
          "unit_id": 1,
          "quantity": 10,
          "unit_price": 50,
          "trade_discount": 150
        },
        {
          "item_id": 11,
          "unit_id": 5,
          "quantity": 20,
          "unit_price": 50,
          "trade_discount": 150
        }
      ]
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle success
        print('Invoice generated successfully $response');
      } else {
        // Handle error
        print('Failed to generate invoice: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('New Tax Invoice'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildProductCard(),
              SizedBox(height: 20),
              buildInvoiceNumberSection(),
              SizedBox(height: 20),
              buildPOReferenceSection(),
              SizedBox(height: 20),
              buildPaymentModeSection(),
              SizedBox(height: 20),
              buildCustomerDetailsSection(),
              SizedBox(height: 20),
              buildShippingAddressSection(),
              SizedBox(height: 20),
              buildPaymentDueDateSection(),
              SizedBox(height: 20),
              buildPlaceOfSupplySection(),
              SizedBox(height: 20),
              buildCashDiscountSection(),
              SizedBox(height: 20),
              buildBankAccountSection(),
              SizedBox(height: 20),
              buildAuthorizedSignatorySection(),
              SizedBox(height: 20),
              buildTermsAndConditionsSection(),
              SizedBox(height: 20),
              buildPaymentSummarySection(),
              SizedBox(height: 20),
              buildGenerateTaxInvoiceButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildProductTile('Leather Bag'),
            buildProductTile('Walking Shoes'),
            buildProductTile('Pink Bag'),
          ],
        ),
      ),
    );
  }

  ListTile buildProductTile(String productName) {
    return ListTile(
      leading: Image.network('https://via.placeholder.com/150'),
      title: Text(productName),
      subtitle: Text(
          'Women\'s Accessories | 35 Pieces\nHSN CODE: 12DHRY334RF'),
      trailing: Text('₹1,200'),
    );
  }

  Widget buildInvoiceNumberSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Invoice Number'),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Invoice Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPOReferenceSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('PO Reference No.'),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter PO Reference No.',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentModeSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Mode', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Cash'),
                    leading: Radio(
                      value: 'Cash',
                      groupValue: paymentMode,
                      onChanged: (value) {
                        setState(() {
                          paymentMode = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Bank'),
                    leading: Radio(
                      value: 'Bank',
                      groupValue: paymentMode,
                      onChanged: (value) {
                        setState(() {
                          paymentMode = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: const Text('Credit'),
              leading: Radio(
                value: 'Credit',
                groupValue: paymentMode,
                onChanged: (value) {
                  setState(() {
                    paymentMode = value!;
                  });
                },
              ),
            ),
            if (paymentMode == 'Credit')
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select Credit Period',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      paymentDueDate = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: paymentDueDate != null
                      ? "${paymentDueDate!.toLocal()}".split(' ')[0]
                      : '',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerDetailsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Customer Details',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    // Add new customer logic here
                  },
                  child: Text('+ Add New'),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Customer Details',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      customer = '';
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShippingAddressSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping address is same as billing address',
                style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: Text('Shipping address is same as billing address'),
              value: true,
              onChanged: (bool? value) {
                // Handle change
              },
            ),
            ListTile(
              title: Text(shippingAddress),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentDueDateSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Due Date',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Select Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != paymentDueDate)
                      setState(() {
                        paymentDueDate = pickedDate;
                      });
                  },
                ),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: paymentDueDate != null
                    ? "${paymentDueDate!.toLocal()}".split(' ')[0]
                    : '',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceOfSupplySection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Place of Supply',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Select Place of Supply',
              ),
              onChanged: (value) {
                setState(() {
                  placeOfSupply = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCashDiscountSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cash Discount',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Cash Discount',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBankAccountSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank Account', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Bank Account',
              ),
              items: ['Account 1', 'Account 2', 'Account 3']
                  .map((String account) {
                return DropdownMenuItem<String>(
                  value: account,
                  child: Text(account),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // Update bank account selection
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthorizedSignatorySection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Authorized Signatory',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Authorized Signatory',
              ),
              items: ['Signatory 1', 'Signatory 2', 'Signatory 3']
                  .map((String signatory) {
                return DropdownMenuItem<String>(
                  value: signatory,
                  child: Text(signatory),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // Update authorized signatory selection
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTermsAndConditionsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms & Conditions',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Terms & Conditions',
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
Widget buildPaymentSummarySection() {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Summary', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10,),
          Row(
            children: [
              Text('Item Total',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              Spacer(),
              Text('Rs 3,600', style: TextStyle(color: Colors.black)),
            ],
          ),
          Row(
            children: [
              Text('Total Taxable Amount', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              Spacer(),
              Text('Rs 3,600'),
            ],
          ),
          Row(
            children: [
              Text('HSN/SAC',style: TextStyle(color: Colors.grey)),
              Spacer(),
              Text('123456789',style: TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Text('CGST + SGST',style: TextStyle(color: Colors.grey)),
              Spacer(),
              Text('Rs 630',style: TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Text('IGST',style: TextStyle(color: Colors.grey)),
              Spacer(),
              Text('Rs 0',style: TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Text('Cash Discount', style: TextStyle(color: Colors.lightGreen)),
              Spacer(),
              Text('Rs 200', style: TextStyle(color: Colors.lightGreen)),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
            height: 20,
            endIndent: 0,
            indent: 0,
          ),
          Row(
            children: [
              Text('Total Amount Payable', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Spacer(),
              Text('Rs 4,000', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    ),
  );
}

  // Widget buildPaymentSummarySection() {
  //   return Card(
  //     elevation: 2,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Payment Summary', style: TextStyle(fontWeight: FontWeight.bold)),
  //         Row(
  //           children: [
  //             Text('Item Total'),
  //             Spacer(),
  //             Text('Rs 3,600')
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text('Total Taxable Amount'),
  //              Spacer(),
  //             Text('Rs 3,600')
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text('HSN/SAC'),
  //              Spacer(),
  //             Text('123456789')
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text('CGST + SGST'),
  //              Spacer(),
  //             Text('Rs 630')
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text('IGST'),
  //              Spacer(),
  //             Text('Rs 0')
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text('Cash Discount', style: TextStyle(color: Colors.lightGreen)),
  //              Spacer(),
  //             Text('Rs 200', style: TextStyle(color: Colors.lightGreen)),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildGenerateTaxInvoiceButton() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: () {
          generateTaxInvoice();
        },
        child: const Text(
          'Generate Tax Invoice',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 45),
          backgroundColor: Color(0xFF1570EF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

