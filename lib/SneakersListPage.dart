import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'SneakersDetailsPage.dart';

class SneakersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Кроссовки')),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('sneakers').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      0.8, // Измените это значение по вашему усмотрению
                  mainAxisSpacing: 0, // Отступ между товарами по вертикали
                  crossAxisSpacing: 0,
                ),
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final sneakers = Sneakers.fromSnapshot(documents[index]);
                  return SneakersListItem(sneakers: sneakers);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class SneakersListItem extends StatelessWidget {
  final Sneakers sneakers;

  const SneakersListItem({Key? key, required this.sneakers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SneakersDetailsPage(
                  sneakers: sneakers,
                  onSizeSelected: (selectedSize) {
                    sneakers.selectedSize = selectedSize ?? '';
                  }),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 185,
                      width: 185,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Image.network(
                          sneakers.photoUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      sneakers.name,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 3),
                    Text(
                      sneakers.price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sneakers {
  final String id;
  final String name;
  final String fullName;
  final String description;
  final String photoUrl;
  final String price;
  final String brand;
  final List<String> sizes;
  final List<String> photoUrls;
  String selectedSize;
  String size;
  int quantity;

  Sneakers({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.photoUrl,
    required this.price,
    required this.brand,
    required this.sizes,
    required this.photoUrls,
    this.selectedSize = '',
    this.size = '',
    this.quantity = 0,
  });

  factory Sneakers.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Sneakers(
      id: data['id'] as String,
      name: data['name'] as String,
      fullName: data['fullName'] as String,
      description: data['description'] as String,
      photoUrl: data['photoUrl'] as String,
      price: data['price'] as String,
      brand: data['brand'] as String,
      photoUrls:
          data['photoUrls'] != null ? List<String>.from(data['photoUrls']) : [],
      sizes: data['sizes'] != null ? List<String>.from(data['sizes']) : [],
    );
  }
}
