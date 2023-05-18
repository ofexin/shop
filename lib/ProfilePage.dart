import 'package:flutter/material.dart';
import 'package:shop/BannerPage.dart';

import 'CartPage.dart';
import 'CatalogPage.dart';
import 'HomePage.dart';
import 'LookPage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ProfilePage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyProfilePage(),
        routes: {
          '/HomePage': (context) => HomePage(),
          '/CatalogPage': (context) => CatalogPage(),
          '/LookPage': (context) => LookPage(),
          '/CartPage': (context) => CartPage(),
          '/ProfilePage': (context) => ProfilePage(),
        });
  }
}

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Column(children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            height: 190,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(children: [
              Center(
                child: Text(
                  "Профиль",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 0,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    'https://avatars.mds.yandex.net/i?id=1a66ffe3a704fdd742bb0c0791423a451fd553df-8497913-images-thumbs&n=13'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                "Андрей Лутов",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BannerPage()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            width: 250,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/card.png'),
                              ),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ])),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          height: 350,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  onSurface: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                    Text(
                      "Заказы",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onSurface: Colors.grey,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.settings_backup_restore_rounded),
                    ),
                    Text(
                      "Возвраты",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.card_giftcard_rounded),
                    ),
                    Text(
                      "Купоны",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.favorite_border),
                    ),
                    Text(
                      "Избранное",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.my_library_books_outlined),
                    ),
                    Text(
                      "Мои данные",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.star_border),
                    ),
                    Text(
                      "Оцените приложение",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.5,
                height: 0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  elevation: 0,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(Icons.help_outline_outlined),
                    ),
                    Text(
                      "Помощь",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ])),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/');
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
