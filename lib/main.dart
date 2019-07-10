import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/filter/filters.dart';
import 'package:meals/meal/detail.dart';
import 'package:meals/meal/meal.dart';
import 'package:meals/meal/meals.dart';
import 'package:meals/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _meals = DUMMY_MEALS.where((meal) {
        if ((_filters['gluten'] && !meal.isGlutenFree) ||
            (_filters['lactose'] && !meal.isLactoseFree) ||
            (_filters['vegan'] && !meal.isVegan) ||
            (_filters['vegetarian'] && !meal.isVegetarian)) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id) {
    setState(() {
      final mealIndex = _favorites.indexWhere((meal) => meal.id == id);

      if (mealIndex < 0) {
        _favorites.add(_meals.firstWhere((meal) => meal.id == id));
      } else {
        _favorites.removeAt(mealIndex);
      }
    });
  }

  bool _isMealFavorite(String id) {
    return _favorites.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (_) => Tabs(_favorites),
        Meals.RouteName: (_) => Meals(_meals),
        MealDetail.RouteName: (_) =>
            MealDetail(_toggleFavorite, _isMealFavorite),
        Filters.RouteName: (_) => Filters(_filters, _setFilters),
      },
    );
  }
}
