import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/provider/productsProvider.dart';
import 'package:shopApp/screen/manageProductScreen.dart';
import 'package:shopApp/widget/mainDrawer.dart';
import 'package:shopApp/widget/userProductItem.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ManageProductScreen.routeName);
            },
          ),
        ],
        title: const Text('Your products'),
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                UserProductItem(
                  id: productsData.items[index].id,
                  imageUrl: productsData.items[index].imageUrl,
                  title: productsData.items[index].title,
                ),
                Divider(),
              ],
            );
          },
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
