import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/new_proforma.dart';
import 'package:flutter_application_1/screens/new_tax_invoice.dart';

class AddItems extends StatefulWidget {
  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItems> {
  int itemCount = 3;
  double totalPrice = 3600;

  // Dropdown items for Selling Unit
  List<String> sellingUnits = ['Piece', 'Set', 'Pair', 'Dozen'];

  // Initial values for fields
  String quantity = '35';
  String rate = '1890';
  String tradeDiscount = '1890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProformaInvoiceScreen()
          ),
        );
            });
          },
        ),
        title: Text('Add Items'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
     body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.woman_rounded, size: 50),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Leather Bag', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text('Women\'s Accessories', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Selling Unit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                            Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Colors.black),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: sellingUnits[0],
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      
                                                    });
                                                  },
                                                  items: sellingUnits.map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Quantity', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              width: 150,
                                              child: TextField(
                                                controller: TextEditingController(text: quantity),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Rate', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              width: 300,
                                              child: TextField(
                                                controller: TextEditingController(text: rate),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                             Text('Trade Discount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              width: 300,
                                              child: TextField(
                                                controller: TextEditingController(text: tradeDiscount),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color.fromARGB(255, 173, 169, 169)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.woman_rounded),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text('$itemCount Items', style: TextStyle(fontSize: 16)),
                    Expanded(child: Text('₹ $totalPrice', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1570EF)))),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NewTaxInvoiceScreen()
          ),
        );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.white),
                      Text('Next',style: TextStyle(color: Colors.white, fontSize: 18),),
                      
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                                         backgroundColor: Color(0xFF1570EF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: Colors.blue),
                                          ),
                                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}