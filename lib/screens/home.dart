import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Marker> markers;
  MapController mapController;
  Map<String, LatLng> coords;
  List<LatLng> points;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    points = List<LatLng>();
    points.add(LatLng(41.8781, -87.6298));
    points.add(LatLng(42.3314, -83.0458));
    points.add(LatLng(42.7325, -84.5555));
    coords = Map<String, LatLng>();
    coords.putIfAbsent("Chicago", () => LatLng(41.8781, -87.6298));
    coords.putIfAbsent("Detroit", () => LatLng(42.3314, -83.0458));
    coords.putIfAbsent("Lansing", () => LatLng(42.7325, -84.5555));

    markers = List<Marker>();
    for (int i = 0; i < coords.length; i++) {
      markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: coords.values.elementAt(i),
        builder: (_) => Icon(Icons.place, color: Colors.red, size: 30.0),
      ));
    }
  }

  void _showCoords(int index) {
    mapController.move(coords.values.elementAt(index), 10);
  }

  List<Widget> _makeButtons() {
    List<Widget> list = List<Widget>();

    for (int i = 0; i < coords.length; i++) {
      list.add(RaisedButton(
        onPressed: () => _showCoords(i),
        child: Text(coords.keys.elementAt(i)),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Flutter Map"),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: _makeButtons(),
                ),
                Flexible(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: LatLng(41.8781, -87.6298),
                      zoom: 5.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(markers: markers),
                      PolylineLayerOptions(
                        polylines: [
                          Polyline(
                            points: points,
                            strokeWidth: 4.0,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
