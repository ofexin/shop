import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cart.dart';
import 'CatalogPage.dart';
import 'HomePage.dart';
import 'LookPage.dart';
import 'ProfilePage.dart';
import 'SneakersListPage.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CartPage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyCartPage(),
        routes: {
          '/HomePage': (context) => HomePage(),
          '/CatalogPage': (context) => CatalogPage(),
          '/LookPage': (context) => LookPage(),
          '/CartPage': (context) => CartPage(),
          '/ProfilePage': (context) => ProfilePage(),
        });
  }
}

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Cart cart = Provider.of<Cart>(context, listen: false);
      cart.loadCartFromFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, _) {
          List<Sneakers?> items = cart.items;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              Sneakers? sneakers = items[index];
              return ListTile(
                leading: Image.network(sneakers!.photoUrl),
                title: Text(sneakers.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Количество: ${sneakers.quantity}'),
                    Text('Цена: ${sneakers.price}'),
                    Text('Размер: ${sneakers.selectedSize}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline_outlined),
                  onPressed: () {
                    cart.removeItem(sneakers);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/HomePage');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home),
                    SizedBox(height: 4),
                    Text('Главная', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/CatalogPage');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.list),
                    SizedBox(height: 4),
                    Text('Каталог', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/LookPage');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.man),
                    SizedBox(height: 4),
                    Text('Подборка', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/CartPage');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(height: 4),
                    Text('Корзина', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/ProfilePage');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person),
                    SizedBox(height: 4),
                    Text('Профиль', style: TextStyle(fontSize: 12)),
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
