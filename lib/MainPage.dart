// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'ProductCard.dart';
//
// class MainPage extends StatefulWidget {
//   const MainPage({super.key});
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedCategory = 'All';
//
//   var decodedBody = {};
//   var products = [];
//   var filteredProducts = [];
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void _clearSearch() {
//     _searchController.clear();
//     _selectedCategory = 'All';
//     _filterProducts();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getAllProducts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/image/logo.png',
//               height: 30,
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               "Get all Products",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {
//               // Implement notifications functionality
//             },
//           ),
//         ],
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             _buildSearchBar(),
//             SizedBox(height: 10),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(
//                     filteredProducts.length,
//                         (index) => Padding(
//                       padding: EdgeInsets.symmetric(vertical: 5.0),
//                       child: ProductCard(
//                         id: filteredProducts[index]['id'],
//                         title: filteredProducts[index]['title'],
//                         description: filteredProducts[index]['description'],
//                         rating: filteredProducts[index]['rating'],
//                         price: filteredProducts[index]['price'],
//                         image: filteredProducts[index]['thumbnail'],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         backgroundColor: Colors.white,
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         elevation: 10,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.search, color: Colors.grey),
//           const SizedBox(width: 10),
//           Expanded(
//             child: TextFormField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search products',
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(color: Colors.grey),
//               ),
//               onChanged: (value) {
//                 _filterProducts();
//               },
//             ),
//           ),
//           GestureDetector(
//             onTap: _clearSearch,
//             child: const Icon(Icons.close, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _filterProducts() {
//     String query = _searchController.text.toLowerCase();
//     String category = _selectedCategory;
//
//     setState(() {
//       filteredProducts = products.where((product) {
//         final titleLower = product['title'].toLowerCase();
//         final matchesQuery = titleLower.contains(query);
//         final matchesCategory = category == 'All' || product['category'] == category;
//         return matchesQuery && matchesCategory;
//       }).toList();
//     });
//   }
//
//   getAllProducts() async {
//     print("All Products");
//     String url = "https://dummyjson.com/products";
//
//     var response = await http.get(Uri.parse(url));
//     var responseBody = response.body;
//     decodedBody = jsonDecode(response.body);
//     print(responseBody);
//     products = decodedBody['products'];
//     filteredProducts = products;
//
//     setState(() {
//       print('setState triggered');
//     });
//   }
// }
//



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ProductCard.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _selectedCategory = 'All';
    _filterProducts();
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/logo.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Flexible(
              child: Text(
                "Get all Products",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implement notifications functionality
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    filteredProducts.length,
                        (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: ProductCard(
                        id: filteredProducts[index]['id'],
                        title: filteredProducts[index]['title'],
                        description: filteredProducts[index]['description'],
                        rating: double.tryParse(filteredProducts[index]['rating'].toString()) ?? 0.0,
                        price: double.tryParse(filteredProducts[index]['price'].toString()) ?? 0.0,
                        image: filteredProducts[index]['image'],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search products',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                _filterProducts();
              },
            ),
          ),
          GestureDetector(
            onTap: _clearSearch,
            child: const Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    String category = _selectedCategory;

    setState(() {
      filteredProducts = products.where((product) {
        final titleLower = product['title'].toLowerCase();
        final matchesQuery = titleLower.contains(query);
        final matchesCategory = category == 'All' || product['category'] == category;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  getAllProducts() async {
    print("All Products");
    String url = "https://fakestoreapiserver.reactbd.com/amazonproducts";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body;
        var decodedBody = jsonDecode(response.body) as List;
        print(responseBody);
        products = decodedBody;
        filteredProducts = products;

        setState(() {
          print('setState triggered');
        });
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}





