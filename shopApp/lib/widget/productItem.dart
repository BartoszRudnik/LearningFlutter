import 'package:flutter/material.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: this.id,
          );
        },
        child: GridTile(
          child: Image.network(
            this.imageUrl,
            fit: BoxFit.cover,
          ),
          header: GridTileBar(
            backgroundColor: Colors.black26,
            leading: Icon(Icons.attach_money),
            title: Text(
              this.price.toStringAsFixed(2),
              textAlign: TextAlign.left,
            ),
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {},
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            backgroundColor: Colors.black54,
            title: Text(
              this.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
