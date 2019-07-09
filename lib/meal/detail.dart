import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const RouteName = '/meal/detail';

  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget buildSectionBody(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageURL,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredents'),
            buildSectionBody(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, i) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(meal.ingredients[i])),
                  );
                },
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildSectionBody(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, i) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${i + 1}'),
                          ),
                          title: Text(meal.steps[i]),
                        ),
                        Divider(),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(id);
        },
      ),
    );
  }
}
