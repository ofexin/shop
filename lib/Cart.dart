import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

import 'SneakersListPage.dart';

class Cart extends ChangeNotifier {
  List<Sneakers?> items = [];

  void addItem(Sneakers sneakers, String size) {
    // Проверяем, есть ли уже товар в корзине
    Sneakers? existingSneakers = items.firstWhereOrNull(
        (item) => item?.id == sneakers.id && item?.size == size);

    if (existingSneakers != null) {
      // Если товар уже есть, увеличиваем количество
      existingSneakers.quantity++;
    } else {
      // Если товара нет, добавляем его в корзину
      sneakers.size = size;
      sneakers.quantity = 1;
      items.add(sneakers);
    }
    saveCartToFirebase();
    notifyListeners();
  }

  void removeItem(Sneakers sneakers) {
    sneakers.quantity--;

    if (sneakers.quantity == 0) {
      items.remove(sneakers);
    }
    saveCartToFirebase();
    notifyListeners();
  }

  Sneakers? getItemById(String id) {
    return items.firstWhere((sneakers) => sneakers!.id == id,
        orElse: () => null);
  }

  // Метод для сохранения данных корзины в базу данных Firebase
  Future<void> saveCartToFirebase() async {
    // Получаем ссылку на коллекцию 'cart'
    CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('cart');

    // Получаем документ 'cart' из коллекции
    DocumentReference cartDocument = cartCollection.doc('cart1');

    // Получаем ссылку на коллекцию 'items'
    CollectionReference itemsCollection = cartDocument.collection('items');

    // Удаляем все документы в коллекции 'items'
    await itemsCollection.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Добавляем или обновляем каждый товар из корзины в коллекцию 'items'
    for (Sneakers? sneakers in items) {
      if (sneakers != null) {
        // Ищем документ товара в коллекции 'items'
        DocumentSnapshot sneakersDoc =
            await itemsCollection.doc(sneakers.id).get();

        if (sneakersDoc.exists) {
          // Если документ существует, обновляем его количество
          sneakersDoc.reference.update({'quantity': sneakers.quantity});
        } else {
          // Если документ не существует, добавляем новый документ
          itemsCollection.doc(sneakers.id + sneakers.size).set({
            'id': sneakers.id,
            'name': sneakers.name,
            'fullName': sneakers.fullName,
            'description': sneakers.description,
            'photoUrl': sneakers.photoUrl,
            'quantity': sneakers.quantity,
            'price': sneakers.price,
            'brand': sneakers.brand,
            'sizes': sneakers.sizes,
            'size': sneakers.size,
            'photoUrls': sneakers.photoUrls,
            'selectedSize': sneakers.selectedSize,
          });
        }
      }
    }
    print('Items loaded successfully');
  }

  // Метод для загрузки данных корзины из базы данных Firebase
  Future<void> loadCartFromFirebase() async {
    CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('cart');
    print('Fetching cart document...');

    DocumentSnapshot cartSnapshot = await cartCollection.doc('cart1').get();
    print('Cart document exists: ${cartSnapshot.exists}');

    if (cartSnapshot.exists) {
      CollectionReference itemsCollection =
          cartSnapshot.reference.collection('items');
      print('Fetching items collection...');

      items = [];
      for (var doc
          in await itemsCollection.get().then((snapshot) => snapshot.docs)) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        items.add(Sneakers(
          id: doc.id,
          name: data['name'],
          fullName: data['fullName'],
          description: data['description'],
          photoUrl: data['photoUrl'],
          price: data['price'],
          quantity: data['quantity'],
          brand: data['brand'],
          size: data['size'],
          selectedSize: data['selectedSize'],
          sizes: List<String>.from(data['sizes']),
          photoUrls: List<String>.from(data['photoUrls']),
        ));
      }

      notifyListeners();
      print('Items loaded successfully');
    }
  }
}
