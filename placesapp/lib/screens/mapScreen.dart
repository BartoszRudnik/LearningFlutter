import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/placeLocation.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation = const PlaceLocation(latitude: 37.422, longitude: -122.08),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      this._pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You maps'),
        actions: <Widget>[
          if (this.widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: this._pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(this._pickedLocation);
                    },
            )
        ],
      ),
      body: GoogleMap(
        onTap: this.widget.isSelecting ? _selectLocation : null,
        markers: (this._pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        this.widget.initialLocation.latitude,
                        this.widget.initialLocation.longitude,
                      ),
                ),
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
