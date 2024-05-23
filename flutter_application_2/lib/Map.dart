import 'package:flutter/material.dart';
import 'package:flutter_application_2/booking_interface.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class BusBookInfo extends StatefulWidget {
  final String chosen_line;

  const BusBookInfo({super.key, required this.chosen_line});
  @override
  _BusBookInfoState createState() => _BusBookInfoState();
}

class _BusBookInfoState extends State<BusBookInfo> {

  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }




  final String _startLocation = 'Irbid';
  String _destinationLocation = '';

  @override
  void initState() {
    getCurrentLocation();
    _destinationLocation=widget.chosen_line;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white!, Colors.white!],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GreetingSection(),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    RouteDisplaySection(_startLocation, _destinationLocation),
              ),
              RouteOptionsSection(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(15)  ),
                      width: double.infinity,
                      height: 250,
                      child: myPosition == null
                        ? const CircularProgressIndicator()
                        : FlutterMap(
                            options: MapOptions(
                                // ignore: deprecated_member_use
                                center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
                            // ignore: deprecated_member_use
                            nonRotatedChildren: [
                              TileLayer(
                                urlTemplate:
                                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                                additionalOptions: const {
                                  'accessToken': MAPBOX_ACCESS_TOKEN,
                                  'id': 'mapbox/streets-v12'
                                },
                              ),
                            ], children: [],
                          )),
                ),
              ),
              NextButtonSection(dest: widget.chosen_line,),
            ],
          ),
        ),
      ),
    );
  }
}

class GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25)),
        color: Colors.indigo,
      ),
      height: 180,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Ready!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'For Best Trip Ever.',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Image.network(
                    "https://static.vecteezy.com/system/resources/previews/007/335/692/original/account-icon-template-vector.jpg",
                    width: 30,
                    height: 30))
          ],
        ),
      ),
    );
  }
}

class RouteDisplaySection extends StatelessWidget {
  final String stationLocation;
  final String destLocation;

  RouteDisplaySection(this.stationLocation, this.destLocation);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.withOpacity(0.4), width: 2)),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.circle_outlined, color: Colors.indigo),
              trailing: Icon(Icons.place, color: Colors.grey),
              title: Text(
                'From',
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              subtitle: Text(
                '$stationLocation ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Colors.grey,
              endIndent: 30,
              indent: 52,
            ),
            ListTile(
              leading: Icon(
                Icons.circle_outlined,
                color: Colors.red,
              ),
              trailing: Icon(
                Icons.place,
                color: Colors.grey,
              ),
              title: Text(
                'To ',
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              subtitle: Text(
                destLocation,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Colors.grey,
              endIndent: 30,
              indent: 52,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class RouteOptionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RouteOptionCard.IconCard(
              icon: Icons.directions_bus_rounded,
              duration: '30 min',
              color: Colors.white),
        ),
      ],
    );
  }
}

class RouteOptionCard extends StatelessWidget {
  final IconData icon;
  final String duration;
  final Color color;

  RouteOptionCard.IconCard(
      {required this.icon, required this.duration, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.indigo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 22, color: color),
            SizedBox(width: 30),
            Text(duration, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}

class MapDisplaySection extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(15)  ),
          width: double.infinity,
          height: 250,
          child: Image.network(
            "https://lh3.googleusercontent.com/tfZjESr_s2pXm6BHKQZGLLEVubrcfIcF6Q08lvc3FxM8mlZEK1ivWViBjLFC2Hd9gVlwQt9xjlt_xhNSpgWK3kkngS6pEIF-5BudWkw=rw-e365-w1024",
            fit: BoxFit.cover,
          )),
    );
  }
}

class NextButtonSection extends StatelessWidget {
  final String dest;
  const NextButtonSection({super.key, required this.dest});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return BookingInterface(chosen_line:dest ,);
            }));
          },
          child: Text('book a seat',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}
