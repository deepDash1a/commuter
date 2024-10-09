import 'dart:async';

import 'package:commuter/core/shared/logic/location_helper.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/core/theme/fonts/font_names.dart';
import 'package:commuter/features/captain/data/captain_shift/place_details_model.dart';
import 'package:commuter/features/captain/data/captain_shift/places_suggestion.dart';
import 'package:commuter/features/captain/logic/cubit.dart';
import 'package:commuter/features/captain/logic/states.dart';
import 'package:commuter/features/captain/ui/widgets/drawer_widgets/captain_map/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:url_launcher/url_launcher.dart';

class CaptainMap extends StatefulWidget {
  const CaptainMap({super.key});

  @override
  State<CaptainMap> createState() => _CaptainMapState();
}

class _CaptainMapState extends State<CaptainMap> {
  // these vars for initialize location
  static final CameraPosition myCurrentCameraPosition = CameraPosition(
    bearing: 0.00,
    tilt: 0.00,
    zoom: 15.00,
    target: LatLng(
      LocationUtils.currentPosition!.latitude,
      LocationUtils.currentPosition!.longitude,
    ),
  );
  Completer<GoogleMapController> completer = Completer();

  // Future<void> getMyCurrentLocation() async {
  //   position = await LocationUtils.getCurrentPosition();
  //   setState(() {});
  //   LocationUtils.streamLocation();
  //   debugPrint('Streeeeeeeeeem: ${LocationUtils.streamSubscription}');
  //   LocationUtils.streamSubscription?.onData(
  //     (data) {
  //       position = data;
  //       setState(() {
  //         debugPrint('Newwwwwwwwwwwwwwwwww: $position');
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               'latitude: ${position!.latitude}, longitude: ${position!.longitude}, Date Time: ${DateTime.now()}',
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

  // search about places
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  List<dynamic> places = [];

  // these vars for get place location
  Set<Marker> markers = {};
  late PlacesSuggestion placesSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.00,
      tilt: 0.00,
      zoom: 15.00,
      target: LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getMyCurrentLocation();
  // }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: markers,
      initialCameraPosition: myCurrentCameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {
        completer.complete(googleMapController);
      },
    );
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController googleMapController = await completer.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        myCurrentCameraPosition,
      ),
    );
  }

  // search for place
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.00, horizontal: 5.00),
      child: FloatingSearchBar(
        controller: floatingSearchBarController,
        hint: 'ابحث ... ',
        hintStyle: const TextStyle(
          fontSize: 16,
          fontFamily: FontNamesManager.bold,
          color: ColorsManager.mainAppColor,
        ),
        queryStyle: const TextStyle(
          fontSize: 16,
          fontFamily: FontNamesManager.bold,
          color: ColorsManager.mainAppColor,
        ),
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 600),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          getPlacesSuggestions(query);
        },
        onFocusChanged: (_) {},
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(
                Icons.place_outlined,
                color: ColorsManager.mainAppColor,
              ),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            color: ColorsManager.mainAppColor,
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSuggestionsPlacesBloc(),
                buildSelectedLocationBloc(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSuggestionsPlacesBloc() {
    return BlocBuilder<CaptainAppCubit, CaptainAppStates>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = (state).placesSuggestion;

          if (places.isNotEmpty) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildPlacesList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            floatingSearchBarController.close();
          },
          child: InkWell(
            onTap: () {
              placesSuggestion = places[index];
              floatingSearchBarController.close();
              getSelectedPlaceLocation();
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          ),
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void getPlacesSuggestions(String query) {
    BlocProvider.of<CaptainAppCubit>(context).emitSuggestions(query);
  }

  // get place and set markers
  void getSelectedPlaceLocation() {
    BlocProvider.of<CaptainAppCubit>(context).emitPlaceLocation(
      placesSuggestion.placeId,
    );
  }

  Widget buildSelectedLocationBloc() {
    return BlocListener<CaptainAppCubit, CaptainAppStates>(
      listener: (context, state) {
        if (state is PlaceDetailsLoaded) {
          selectedPlace = (state).placeLocation;
          gotoSearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  Future<void> gotoSearchedForLocation() async {
    buildCameraNewPosition();
    GoogleMapController controller = await completer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        goToSearchedForPlace,
      ),
    );
    buildSearchedPlaceMarker();
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: const MarkerId('2'),
      onTap: () {
        launchDefaultMapApp();
      },
      infoWindow: InfoWindow(
        title: placesSuggestion.description,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    );
    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  void launchDefaultMapApp() async {
    try {
      final Uri geoUri = Uri(
        scheme: 'geo',
        path:
            '${selectedPlace.result.geometry.location.lat},${selectedPlace.result.geometry.location.lng}',
        queryParameters: {
          'q':
              '${selectedPlace.result.geometry.location.lat},${selectedPlace.result.geometry.location.lng}'
        },
      );

      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch maps for location $geoUri';
      }
    } catch (e) {
      debugPrint('Error launching map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.white,
            size: 20.00,
          ),
        ),
        title: Text(
          'الخريطة',
          style: TextStyle(
              fontSize: 18.00.sp,
              fontFamily: FontNamesManager.bold,
              color: ColorsManager.white),
        ),
      ),
      body: SafeArea(
        child: SharedPrefService.getData(key: SharedPrefKeys.shiftId) == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity.w,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.00.w,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.00.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.00.w,
                        vertical: 15.00.h,
                      ),
                      child: const Center(
                        child: RegularText16dark(
                          text: 'لم تبدء دورية اليوم حتي الان',
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LocationUtils.currentPosition == null
                      ? const Center(child: CircularProgressIndicator())
                      : buildMap(),
                  buildFloatingSearchBar(),
                ],
              ),
      ),
      floatingActionButton:
          SharedPrefService.getData(key: SharedPrefKeys.shiftId) == null
              ? const SizedBox()
              : LocationUtils.currentPosition == null
                  ? const SizedBox()
                  : FloatingActionButton(
                      onPressed: goToMyCurrentLocation,
                      backgroundColor: ColorsManager.mainAppColor,
                      child: const Icon(
                        Icons.place_outlined,
                        color: ColorsManager.white,
                      ),
                    ),
    );
  }
}
