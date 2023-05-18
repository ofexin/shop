import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'CatalogPage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';

class LookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LookPage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyLookPage(),
        routes: {
          '/HomePage': (context) => HomePage(),
          '/CatalogPage': (context) => CatalogPage(),
          '/LookPage': (context) => LookPage(),
          '/CartPage': (context) => CartPage(),
          '/ProfilePage': (context) => ProfilePage(),
        });
  }
}

class MyLookPage extends StatefulWidget {
  @override
  _MyLookPageState createState() => _MyLookPageState();
}

class _MyLookPageState extends State<MyLookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('This is the look page'),
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
