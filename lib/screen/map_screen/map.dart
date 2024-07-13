import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water/Utils/fonstyle.dart';
import 'package:water/Utils/whitespaceutils.dart';
import 'package:water/Utils/widgets/stackedscaffold.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';
import 'package:water/utils/color_utils.dart';
import 'package:water/utils/uttil_helper.dart';

import '../../utils/app_state.dart';

class MapScreen extends StatefulWidget {
  final double userLatitude;
  final double userLongitude;
  final String items;
  final String paymentMethod;
  final String date;

  const MapScreen(
      {Key? key,
      required this.userLatitude,
      required this.userLongitude,
      required this.items,
      required this.date,
      required this.paymentMethod})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late BitmapDescriptor? icon;
  late GoogleMapController _controller;
  late List<LatLng> markers = [];

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];

  double? latitude;
  double? longitude;

  LatLng? _center;

  Position? currentLocation;

  BitmapDescriptor? customIcon;

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation!.latitude, currentLocation!.longitude);
    });
    markers = [
      _center!,
      LatLng(
        double.parse(widget.userLatitude.toString()),
        double.parse(widget.userLongitude.toString()),
      )
    ];
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyB_kIX5UrOzY9KC14LVNRAIsZCkx3xBXeA',
      PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
      PointLatLng(widget.userLatitude, widget.userLongitude),
      travelMode: TravelMode.driving,
    )
        .then((value) {
      for (var point in value.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }).then((value) {
      addPolyLine();
    });
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        jointType: JointType.mitered,
        polylineId: id,
        color: ColorUtils.kcSecondary,
        points: polylineCoordinates);
    polyLines[id] = polyline;
    setState(() {});
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'asset/icons/gps.png');
  }

  @override
  void initState() {
    setCustomMarker();
    getUserLocation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  GlobalKey<ScaffoldState> theGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StackedScaffold(
      leadingIcon: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: InkResponse(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(UtilsHelper.rightHandLang.contains(appState.currentLanguageCode.value)? 
             Icons.arrow_forward
            :Icons.arrow_back,color: isDark.value ? Colors.white : null,)),
      ),
      stackedEntries: [
        Align(
          alignment: const Alignment(0, 1),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 27, right: 27, top: 24),
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 96,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark.value ? ColorUtils.kcCardColor: ColorUtils.kcWhite,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: ColorUtils.kcTransparent.withOpacity(.1),
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                    blurRadius: 30),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.paymentMethod,
                      style: FontStyleUtilities.t1(
                          fontColor: ColorUtils.kcLightTextColor),
                    ),
                    Text(
                      '${UtilsHelper.getString(context, 'item')} - ${widget.items}',
                      style: FontStyleUtilities.h5(fontWeight: FWT.regular),
                    )
                  ],
                ),
                SpaceUtils.ks16.height(),
                Text(widget.date,
                    style: FontStyleUtilities.t1(
                        fontColor: ColorUtils.kcLightTextColor)),
                //  SpaceUtils.ks16.height(),
              ],
            ),
          ),
        )
      ],
      extendBody: true,
      extendBodyBehindAppBar: true,
      tittle: UtilsHelper.getString(context, 'delivery_address'),
      body: _center==null ? Container(
        child: const Center(child: CircularProgressIndicator()),
      ) : SafeArea(
        child: GoogleMap(
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          compassEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          polylines: Set<Polyline>.of(polyLines.values),
          onTap: (LatLng x) {},
          markers: {
            ...List<Marker>.generate(
                markers.length,
                (index) => Marker(
                    onTap: () {},
                    icon: BitmapDescriptor.defaultMarker,
                    markerId: MarkerId(index.toString()),
                    position: markers[index])).toList()
          },
          initialCameraPosition: CameraPosition(
            zoom: 18,
            target: _center!,
          ),
        ),
      ),
    );
  }
}
