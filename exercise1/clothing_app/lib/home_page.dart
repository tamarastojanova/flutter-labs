import 'package:clothing_app/details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> clothes = [
    {
      'name': 'Padded parka',
      'image':
          'https://static.e-stradivarius.net/5/photos4/2024/I/0/1/p/5811/273/004/5811273004_2_16_1.jpg?ts=1729783914271&imformat=chrome&imdensity=2&impolicy=undefined',
      'description':
          'Padded midi parka with a high neck and hood with detachable faux fur trim and adjustable matching drawstrings. Long sleeves with elastic cuffs. Front patch pockets with buttoned flaps. Elastic waist at the back. Combined faux fur lining.',
      'price': 69.99,
    },
    {
      'name': 'Text print T-shirt',
      'image':
          'https://static.e-stradivarius.net/assets/public/39ff/8b1b/8242431aa041/9b02e9714ea1/02617512001-c/02617512001-c.jpg?ts=1723203703837',
      'description':
          'Loose-fitting T-shirt made of cotton. Round neck and short sleeves. Print detail on the front. Available in several colours.',
      'price': 7.99,
    },
    {
      'name': 'Wide-leg trousers',
      'image':
          'https://static.e-stradivarius.net/assets/public/f321/9c49/4fca450080d2/baff8d6f9d89/04502385001-c/04502385001-c.jpg?ts=1727970608631',
      'description':
          'Mid-rise wide-leg trousers with double belt loops. Featuring side pockets, a straight and wide-leg design, double belts in the same fabric with adjustable tie and metal hook, hidden button and zip fastening at the front. Available in assorted colours.',
      'price': 25.99,
    },
    {
      'name': 'Knit sweater',
      'image':
          'https://static.e-stradivarius.net/assets/public/6b59/c26e/cc8840beb071/2c60718592d0/05117979430-c/05117979430-c.jpg?ts=1732525458903',
      'description':
          'Oversize knit sweater with a round neckline, long sleeves and ribbed trims.',
      'price': 39.99,
    },
    {
      'name': 'Tote bag',
      'image':
          'https://static.e-stradivarius.net/5/photos4/2024/I/0/1/p/3678/711/001/3678711001_1_1_1.jpg?ts=1729092324233&imformat=chrome&imdensity=2&impolicy=undefined',
      'description': 'Structured tote bag with compartments',
      'price': 25.99,
    },
  ];

  void _addNewClothingItem() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    double? getPrice() {
      final numericString =
          priceController.text.replaceAll(RegExp(r'[^0-9\.]'), '');
      if (numericString.isEmpty) return 0;
      return double.tryParse(numericString);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Clothing Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  clothes.add({
                    'name': nameController.text,
                    'image': imageController.text.isEmpty
                        ? 'https://via.placeholder.com/150'
                        : imageController.text,
                    'description': descriptionController.text,
                    'price': getPrice(),
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 182, 193),
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            mainAxisExtent: 250,
          ),
          itemCount: clothes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(item: clothes[index]),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image.network(
                        clothes[index]['image'],
                        height: 185,
                        width: 155,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          clothes[index]['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewClothingItem,
        tooltip: 'Add New Clothing Item',
        backgroundColor: const Color.fromARGB(255, 255, 177, 193),
        child: const Icon(Icons.add),
      ),
    );
  }
}
