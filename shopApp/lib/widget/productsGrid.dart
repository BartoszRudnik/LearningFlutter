import 'package:flutter/material.dart';
import 'package:shopApp/provider/productsProvider.dart';
import 'package:shopApp/widget/productItem.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<ProductsProvider>(context);
    final products = showFavorites ? loadedProducts.favoriteItems : loadedProducts.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
          price: products[index].price,
          id: products[index].id,
          title: products[index].title,
          imageUrl: products[index].imageUrl,
        ),
      ),
      itemCount: products.length,
    );
  }
}
