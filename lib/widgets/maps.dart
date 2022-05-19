import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({
    @required this.onMapLoaded,
    @required this.onMapTapped,
    this.markers,
    this.showMyLocationButton = false,
  });

  final bool showMyLocationButton;
  final Function(GoogleMapController) onMapLoaded;
  final Function(LatLng) onMapTapped;
  final Set<Marker> markers;

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<Maps> {
  LocationData _userLocation;
  GoogleMapController _mapController;

  void _loadUserLocation() async {
    _userLocation = await Location().getLocation();
    await _mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
          _userLocation?.latitude ?? 0.0, _userLocation?.longitude ?? 0.0),
      zoom: 20.0,
    )));
  }

  @override
  void initState() {
    _loadUserLocation();

    super.initState();
  }

  void _onMapCreated(GoogleMapController mapController) async {
    _mapController = mapController;
    _loadUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _onMapCreated(controller);
            widget.onMapLoaded(controller);
          },
          onCameraIdle: () {
            //do nothing
          },
          onTap: (LatLng latLng) {
            widget.onMapTapped(latLng);
          },
          markers: widget.markers ?? <Marker>{},
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(_userLocation?.latitude ?? 0.0,
                _userLocation?.longitude ?? 0.0),
            zoom: 15.0,
          ),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
        ),
        if (widget.showMyLocationButton)
          Positioned(
            bottom: 30,
            right: 0,
            child: RaisedButton(
              onPressed: _loadUserLocation,
              child: SizedBox(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
              ),
              shape: CircleBorder(),
              color: Colors.white,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController = null;
    super.dispose();
  }
}