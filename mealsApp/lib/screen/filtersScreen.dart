import 'package:flutter/material.dart';
import 'package:mealsApp/widget/filterItem.dart';
import 'package:mealsApp/widget/mainDrawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function setFilters;
  final Map<String, bool> filtres;

  FiltersScreen({
    @required this.setFilters,
    @required this.filtres,
  });

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    this._glutenFree = this.widget.filtres['gluten'];
    this._lactoseFree = this.widget.filtres['lactose'];
    this._vegan = this.widget.filtres['vegan'];
    this._vegetarian = this.widget.filtres['vegetarian'];
    super.initState();
  }

  void changeGlutenFree(bool newValue) {
    setState(() {
      this._glutenFree = newValue;
    });
  }

  void changeLactoseFree(bool newValue) {
    setState(() {
      this._lactoseFree = newValue;
    });
  }

  void changeVegan(bool newValue) {
    setState(() {
      this._vegan = newValue;
    });
  }

  void changeVegetarian(bool newValue) {
    setState(() {
      this._vegetarian = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFiltres = {
                'gluten': this._glutenFree,
                'lactose': this._lactoseFree,
                'vegan': this._vegan,
                'vegetarian': this._vegetarian,
              };
              this.widget.setFilters(selectedFiltres);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meals selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                FilterItem(
                  changeFilter: changeGlutenFree,
                  setting: _glutenFree,
                  subtitle: 'Show only gluten-free meals',
                  title: 'Gluten-Free',
                ),
                FilterItem(
                  changeFilter: changeVegetarian,
                  title: 'Vegetarian',
                  subtitle: 'Show only vegetarian meals',
                  setting: _vegetarian,
                ),
                FilterItem(
                  changeFilter: changeVegan,
                  title: 'Vegan',
                  subtitle: 'Show only vegan meals',
                  setting: _vegan,
                ),
                FilterItem(
                  changeFilter: changeLactoseFree,
                  title: 'Lactose-Free',
                  subtitle: 'Show only lactose-free meals',
                  setting: _lactoseFree,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
