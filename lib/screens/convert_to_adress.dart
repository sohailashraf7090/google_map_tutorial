import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';

class ConvertToAdress extends StatefulWidget {
  const ConvertToAdress({super.key});

  @override
  State<ConvertToAdress> createState() => _ConvertToAdressState();
}

class _ConvertToAdressState extends State<ConvertToAdress> {
  String stAdress = "";
  String stCordinate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAdress),
          const SizedBox(
            height: 10,
          ),
          Text(stCordinate),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                print("tap");
                // var adress = await Geocoder.local
                //     .findAddressesFromCoordinates(coordinates);

                List<Location> locations =
                    await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(52.2165157, 6.9437819);
                setState(() {
                  // ignore: prefer_interpolation_to_compose_strings
                  stAdress = locations.last.latitude.toString() +
                      "    " +
                      locations.last.longitude.toString();
                  stCordinate = placemarks.reversed.last.country.toString();
                });
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(color: Colors.green),
                child: const Center(child: Text("Converter")),
              ),
            ),
          )
        ],
      ),
    );
  }
}
