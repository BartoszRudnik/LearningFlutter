import 'package:flutter/material.dart';
import 'package:placesapp/providers/greatPlaces.dart';
import 'package:placesapp/screens/addPlace.dart';
import 'package:placesapp/screens/placeDetail.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('You have no places added, start adding new places!'),
                ),
                builder: (ctx, placesData, ch) => placesData.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(placesData.items[index].image),
                          ),
                          title: Text(
                            placesData.items[index].title,
                          ),
                          subtitle: Text(placesData.items[index].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetail.routeName,
                              arguments: placesData.items[index].id,
                            );
                          },
                        ),
                        itemCount: placesData.items.length,
                      ),
              ),
      ),
    );
  }
}
