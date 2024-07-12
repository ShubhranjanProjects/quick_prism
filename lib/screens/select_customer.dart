import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/new_proforma.dart';
import 'package:flutter_application_1/screens/widgets/custom_bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
 
class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);
 
  @override
  State<ListScreen> createState() => _ListScreenState();
}
 
class _ListScreenState extends State<ListScreen> {
  int _selectedIndex = 0; // Add this line to track selected index
  List<Map<String, dynamic>> customers = [];
 
  @override
  void initState() {
    super.initState();
    fetchData();
  }
 
  
  Future<void> fetchData() async {
    try {
      var url = Uri.parse(
          'http://3.108.137.111:4000/employee/v1/vendor?is_guest=1&business_id=7');
 
      var response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJxcGlkIjo0OSwic2Vzc2lvbl9pZCI6NjcsImlhdCI6MTcyMDY4MjM3NSwiZXhwIjoxNzIxOTc4Mzc1LCJpc3MiOiJxdWlja3ByaXNtIn0.Ntkph4cSkV91etlPkdJZRdk5af2h3xXe-QFFastGIh8',
          'Content-Type':
              'application/json', // Adjust content-type if necessary
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          customers = data
              .map((item) => {
                    'Name': item['vendor_name'],
                    'QPID': item['qpid'].toString(),
                  })
              .toList();
        });
        debugPrint("Customers: $customers");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
 
  void _addNewGuest() {
    setState(() {
      customers.add({
        'Name': 'New Guest',
        'QPID': '919999999999',
      });
    });
  }
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index when item tapped
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProformaInvoiceScreen()),
      );
    }
    // Add navigation logic for other items if needed
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Select Customer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Color(0xFF1570EF)),
                hintText: 'Search by QPID or Phone No.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  textColor: Colors.black,
                  leading: Icon(Icons.abc),
                  title: Text(customers[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("QPID:${customers[index]['QPID']}", style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.phone,color: Colors.blue,),
                    onPressed: () {
                      // Implement call functionality
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton(
              onPressed: _addNewGuest,
              child: const Text('Add New Guest',style: TextStyle(color: Colors.white,fontSize: 18),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 45),
                                         backgroundColor: Color(0xFF1570EF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            side: BorderSide(color: Colors.blue),
                                          ),
                                        ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: _selectedIndex, // Set current index
      //   onTap: _onItemTapped, // Handle item tap
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'List',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}