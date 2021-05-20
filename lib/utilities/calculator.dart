import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:latlong/latlong.dart';

class Calculator {
  static double calculateDistanceBetweenTwoPoints(maps.LatLng first, maps.LatLng second) {
    final Distance distance = Distance();
    return distance.distance(LatLng(first.latitude, first.longitude), LatLng(second.latitude, second.longitude));
  }

  static bool isTwoPointsEqual(maps.LatLng first, maps.LatLng second) {
    return calculateDistanceBetweenTwoPoints(first, second) == 0.0;
  }
}
