import 'package:flutter/material.dart';
import 'SneakersDetailsPage.dart';
import 'SneakersListPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SneakersSearchItem extends StatelessWidget {
  final Sneakers sneakers;

  const SneakersSearchItem({Key? key, required this.sneakers})
      : super(key: key);

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
                },
              ),
            ),
          );
        },
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
    );
  }
}
