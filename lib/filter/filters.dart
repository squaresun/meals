import 'package:flutter/material.dart';
import 'package:meals/drawer.dart';

class Filters extends StatefulWidget {
  static const RouteName = '/filters';

  final Map<String, bool> prevFilters;
  final Function setFilters;

  Filters(this.prevFilters, this.setFilters);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.prevFilters['gluten'];
    _vegetarian = widget.prevFilters['vegetarian'];
    _vegan = widget.prevFilters['vegan'];
    _lactoseFree = widget.prevFilters['lactose'];
  }

  Widget _buildSwitchItem(
    String title,
    bool value,
    Function onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      subtitle: Text('Only include ${title.toLowerCase()} meals'),
      onChanged: (value) {
        setState(() {
          onChanged(value);
          _setFilters();
        });
      },
    );
  }

  void _setFilters() {
    widget.setFilters({
      'gluten': _glutenFree,
      'lactose': _lactoseFree,
      'vegetarian': _vegetarian,
      'vegan': _vegan,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Adjust meal filters',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchItem(
                  'Gluten-free',
                  _glutenFree,
                  (value) {
                    _glutenFree = value;
                  },
                ),
                _buildSwitchItem(
                  'Lactose-free',
                  _lactoseFree,
                  (value) {
                    _lactoseFree = value;
                  },
                ),
                _buildSwitchItem(
                  'Vegetarian',
                  _vegetarian,
                  (value) {
                    _vegetarian = value;
                  },
                ),
                _buildSwitchItem(
                  'Vegan',
                  _vegan,
                  (value) {
                    _vegan = value;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
