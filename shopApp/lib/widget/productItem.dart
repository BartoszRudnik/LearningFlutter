import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/model/cart.dart';
import 'package:shopApp/model/product.dart';
import 'package:shopApp/screen/productDetailScreen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  ProductItem({
    @required this.price,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          header: GridTileBar(
            backgroundColor: Colors.black26,
            leading: Icon(Icons.attach_money),
            title: Text(
              product.price.toStringAsFixed(2),
              textAlign: TextAlign.left,
            ),
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  try {
                    await product.toggleFavoriteStatus();
                  } catch (error) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(
                      seconds: 2,
                    ),
                    content: Text(
                      'Added item to cart',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
              color: Theme.of(context).accentColor,
            ),
            backgroundColor: Colors.black54,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
