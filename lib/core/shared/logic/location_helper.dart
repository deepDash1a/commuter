import 'dart:async';
import 'dart:io';

import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationUtils {
  static Position? currentPosition;
  static String currentAddress = '';
  static CameraPosition? myCurrentCameraPosition;
  static StreamSubscription<Position>? streamSubscription;
  static Timer? locationTimer;

  static final LocationSettings _locationSettings = Platform.isAndroid
      ? AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1,
          intervalDuration: const Duration(milliseconds: 5000),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText: "Running location",
            notificationIcon:
                AndroidResource(name: 'launcher_icon', defType: 'mipmap'),
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ),
        )
      : Platform.isIOS
          ? AppleSettings(
              accuracy: LocationAccuracy.high,
              pauseLocationUpdatesAutomatically: true,
              showBackgroundLocationIndicator: false,
              distanceFilter: 1,
            )
          : const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 1,
            );

  static Future<bool> requestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // Check if location services are disabled and open location settings.
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();

      // After opening settings, wait for the user to enable location services.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // If location services are still disabled, return an error.
      if (!serviceEnabled) {
        return Future.error('Location services are still disabled.');
      }
    }

    // Check and request location permissions.
    if (!await requestPermissions()) {
      return Future.error('Location permissions are denied.');
    }

    // Finally, get the current position if everything is enabled.
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  static Future<void> getCurrentAddress() async {
    currentPosition = await getCurrentPosition();
    myCurrentCameraPosition = CameraPosition(
      bearing: 0.00,
      tilt: 0.00,
      zoom: 17,
      target: LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ),
    );

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      currentPosition!.latitude,
      currentPosition!.longitude,
    );

    if (placeMarks.isNotEmpty) {
      Placemark placeMark = placeMarks.first;
      currentAddress =
          "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.country}, ${placeMark.postalCode}";
    } else {
      currentAddress = "No address found.";
    }
  }

  static void streamLocation() async {
    if (!await requestPermissions()) {
      if (kDebugMode) {
        print('Location permissions are denied.');
      }
      return;
    }

    streamSubscription =
        Geolocator.getPositionStream(locationSettings: _locationSettings)
            .listen(
      (Position position) async {
        currentPosition = position;

        List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentPosition!.latitude,
          currentPosition!.longitude,
        );

        String newAddress = "No address found.";
        if (placeMarks.isNotEmpty) {
          Placemark placeMark = placeMarks.first;
          newAddress =
              "${placeMark.street}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.country}, ${placeMark.postalCode}";
        }

        if (locationTimer == null || !locationTimer!.isActive) {
          locationTimer =
              Timer.periodic(const Duration(milliseconds: 5000), (timer) async {
            await storeLocation(
              SharedPrefService.getData(key: SharedPrefKeys.shiftId),
              newAddress,
              position.latitude,
              position.longitude,
            );
          });
        }
      },
      onError: (error) {
        print("Error in location stream: $error");
      },
    );
  }

  static Future<void> storeLocation(
      int shiftId, String address, double latitude, double longitude) async {
    try {
      final requestData = {
        'shiftId': shiftId, // Ensure you're passing the shiftId correctly
        'locationName': address,
        'latitude': latitude,
        'longitude': longitude,
      };
      final response = await Dio().post(
        'https://commuter.commuterscarpoling.net/api/shift/location-update',
        data: requestData,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}',
            'Content-Type': 'application/json', // Add content type if necessary
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Location updated successfully: ${response.data}');
      } else {
        print(
            'Failed to update location: ${response.statusCode} - ${response.data}');
      }
    } catch (error) {
      print(error);
    }
  }

  static void stopLocationTracking() {
    streamSubscription?.cancel();
    locationTimer?.cancel();
    locationTimer = null;
  }
}
