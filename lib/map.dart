import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(FontAwesomeIcons.arrowLeft),
        //     onPressed: () {
        //       //
        //     }),
        title: Text("Maps"),     
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipOBIDNx7GOIndjk0JM0T-lXHfhZ1RDK5Ik_AOAs=w426-h240-k-no",
                  11.320775,
                  75.933986,
                  "ABC Hall"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPNs7Zm08kXoWt1hlpYIck7EH_Atno5-e7lC8Ku=w408-h302-k-no",
                  11.321742,
                  75.932980,
                  "NLHC Hall"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipOlHLo3d4YYrqKJUw_jUe-On59_oXB4mXyieP0Z=w408-h306-k-no",
                  11.321508,
                  75.934088,
                  "Centre Circle"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipM01ZkJJQNGOkvUf0nBc_2bHJNEb9KEdX0Uohg9=w408-h725-k-no",
                  11.321750,
                  75.934112,
                  "Help Desk"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipOBIDNx7GOIndjk0JM0T-lXHfhZ1RDK5Ik_AOAs=w426-h240-k-no",
                  11.321606,
                  75.933640,
                  "Triple C"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipOBIDNx7GOIndjk0JM0T-lXHfhZ1RDK5Ik_AOAs=w426-h240-k-no",
                  11.322541,
                  75.935828,
                  "Auditorium"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipOBIDNx7GOIndjk0JM0T-lXHfhZ1RDK5Ik_AOAs=w426-h240-k-no",
                  11.322276,
                  75.933350,
                  "Out-door Auditorium"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Event:Event 1",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Time : 00:00-00:00",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(11.3216, 75.9336), zoom: 20),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          mainbuildingMarker,
          cccMarker,
          audiMarker,
          oatMarker,
          abchallMarker,
          nlhcMarker,
          blueMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 20,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

//Markers
Marker abchallMarker = Marker(
  markerId: MarkerId('abchall'),
  position: LatLng(11.320775, 75.933986),
  infoWindow: InfoWindow(title: 'ABC Hall'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker nlhcMarker = Marker(
  markerId: MarkerId('nlhc'),
  position: LatLng(11.321742, 75.932980),
  infoWindow: InfoWindow(title: 'NLHC'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('centrecircle'),
  position: LatLng(11.321508, 75.934088),
  infoWindow: InfoWindow(title: 'Centre Circle'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker mainbuildingMarker = Marker(
  markerId: MarkerId('mainbuilding'),
  position: LatLng(11.321750, 75.934112),
  infoWindow: InfoWindow(title: 'Help Desk'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker cccMarker = Marker(
  markerId: MarkerId('ccc'),
  position: LatLng(11.321606, 75.933640),
  infoWindow: InfoWindow(title: 'Triple C'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker audiMarker = Marker(
  markerId: MarkerId('audi'),
  position: LatLng(11.322541, 75.935828),
  infoWindow: InfoWindow(title: 'Auditorium'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker oatMarker = Marker(
  markerId: MarkerId('oat'),
  position: LatLng(11.322276, 75.933350),
  infoWindow: InfoWindow(title: 'Out-door Auditorium'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);