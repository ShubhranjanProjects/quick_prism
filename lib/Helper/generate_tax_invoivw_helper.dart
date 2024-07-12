import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> generateTaxInvoice() async {
  const url = 'http://3.108.137.111:4000/stocks/v1/b2b/tax_invoice';
  const headers = {
    'Content-Type': 'application/json',
    'Authorization': '••••••', // Replace with your actual token
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
      print('Invoice generated successfully');
    } else {
      // Handle error
      print('Failed to generate invoice: ${response.statusCode}');
    }
  } catch (e) {
    // Handle network error
    print('Error: $e');
  }
}
