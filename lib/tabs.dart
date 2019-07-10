import 'package:flutter/material.dart';
import 'package:meals/category/categories.dart';
import 'package:meals/drawer.dart';
import 'package:meals/favorite/favorites.dart';
import 'package:meals/meal/meal.dart';

class Tabs extends StatefulWidget {
  final List<Meal> _favorites;

  Tabs(this._favorites);
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final List<String> _titles = [
    'Categories',
    'Favorites',
  ];

  List<Widget> _pages;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      Categories(),
      Favorites(widget._favorites),
    ];
  }

  void _selectPage(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedIndex]),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text(
                _titles[0],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text(
                _titles[1],
              ),
            ),
          ],
          onTap: _selectPage,
        ),
      ),
      length: 2,
    );
  }
}
