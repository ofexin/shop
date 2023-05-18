import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shop/SneakersListPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'Cart.dart';

typedef SizeSelectedCallback = void Function(String? selectedSize);

class SneakersDetailsPage extends StatefulWidget {
  final Sneakers sneakers;
  final SizeSelectedCallback onSizeSelected;

  const SneakersDetailsPage(
      {Key? key, required this.sneakers, required this.onSizeSelected})
      : super(key: key);

  @override
  _SneakersDetailsPageState createState() => _SneakersDetailsPageState();
}

class _SneakersDetailsPageState extends State<SneakersDetailsPage> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Кроссовки')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  // aspectRatio: 1.0,
                  // enlargeCenterPage: true,
                ),
                items: widget.sneakers.photoUrls.map((photoUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(photoUrl,
                          //  fit: BoxFit.contain,
                          fit: BoxFit.cover,
                          width: 1000);
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.sneakers.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.sneakers.brand,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      final int sizeNumber = 36 + index;
                      final String size = sizeNumber.toString();

                      if (sizeNumber < 36 || sizeNumber > 44) {
                        return Container();
                      }

                      final int nextSizeNumber = sizeNumber + 1;
                      final String nextSize = nextSizeNumber.toString();

                      final bool isSelected = size == selectedSize;

                      return Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(right: 3),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedSize = size;
                            });
                            widget.onSizeSelected(selectedSize);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey;
                                } else if (isSelected) {
                                  return Colors.black;
                                }
                                return Colors.white;
                              },
                            ),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                              (Set<MaterialState> states) {
                                if (isSelected) {
                                  return BorderSide.none;
                                }
                                return BorderSide(
                                    color: Colors.grey, width: 2.0);
                              },
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'О товаре',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(widget.sneakers.description),
              ),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                          width: 400,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              cart.addItem(widget.sneakers,
                                  widget.sneakers.selectedSize);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            child: Text('Добавить в корзину'),
                          )))),
            ],
          ),
        ),
      ),
    );
  }
}

class SneakersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('sneakers').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            Sneakers sneakers = Sneakers(
              id: data['id'],
              name: data['name'],
              fullName: data['fullName'],
              description: data['description'],
              photoUrl: data['photoUrl'],
              price: data['price'],
              brand: data['brand'],
              size: data['size'],
              sizes: List<String>.from(data['sizes']),
              photoUrls: List<String>.from(data['photoUrls']),
            );

            return GestureDetector(
              child: Card(
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.network(sneakers.photoUrl),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        sneakers.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
