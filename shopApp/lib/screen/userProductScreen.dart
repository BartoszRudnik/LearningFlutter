import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/productsProvider.dart';
import 'manageProductScreen.dart';
import '../widget/mainDrawer.dart';
import '../widget/userProductItem.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

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
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
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
      ),
    );
  }
}
