import 'package:flutter/material.dart';
import 'package:meals/meal/meal.dart';
import 'package:meals/meal/item.dart';

class Favorites extends StatelessWidget {
  final List<Meal> _favorites;

  Favorites(this._favorites);

  @override
  Widget build(BuildContext context) {
    if (_favorites.isEmpty) {
      return Container(
        child: Text(('No favorites yet')),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return MealItem(
          id: _favorites[i].id,
          title: _favorites[i].title,
          imageURL: _favorites[i].imageURL,
          affordability: _favorites[i].affordability,
          duration: _favorites[i].duration,
          complexity: _favorites[i].complexity,
        );
      },
      itemCount: _favorites.length,
    );
  }
}
