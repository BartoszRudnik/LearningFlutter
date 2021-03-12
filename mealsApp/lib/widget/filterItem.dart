import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  bool setting;
  String title;
  String subtitle;
  Function changeFilter;

  FilterItem({
    @required this.changeFilter,
    @required this.title,
    @required this.subtitle,
    @required this.setting,
  });

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: this.widget.setting,
      onChanged: (newValue) {
        this.widget.changeFilter(newValue);
      },
      title: Text(this.widget.title),
      subtitle: Text(
        this.widget.subtitle,
      ),
    );
  }
}
