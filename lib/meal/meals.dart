import 'package:flutter/material.dart';

import 'package:meals/meal/item.dart';
import 'package:meals/meal/meal.dart';

class Meals extends StatefulWidget {
  static const RouteName = '/meals';

  final List<Meal> _meals;

  Meals(this._meals);

  @override
  _MealsState createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  String title;
  List<Meal> meals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (meals == null) {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      final id = args['id'];
      title = args['title'];
      meals = widget._meals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
    }
  }

  void _removeItem(String id) {
    setState(() {
      meals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            id: meals[i].id,
            title: meals[i].title,
            imageURL: meals[i].imageURL,
            affordability: meals[i].affordability,
            duration: meals[i].duration,
            complexity: meals[i].complexity,
            removeItem: _removeItem,
          );
        },
        itemCount: meals.length,
      ),
    );
  }
}
