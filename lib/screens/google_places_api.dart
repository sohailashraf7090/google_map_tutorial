import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({super.key});

  @override
  State<GooglePlacesApi> createState() => _nameState();
}

class _nameState extends State<GooglePlacesApi> {
  final TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  String sessionToken = "11223344";
  List<dynamic> placesLists = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACESAPIKEY = "AIzaSyDmH3O0-yRhX7ihR8Wl-T9wMDTQQ5bINdk";

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString;
    print("data");
    print(data);

    if (response.statusCode == 200) {
      setState(() {
        placesLists = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Google Places Api")),
        ),
        body: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "search by name"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: placesLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () async {
                      List<Location> locations = await locationFromAddress(
                          placesLists[index]['description']);
                      print(locations.last.latitude);
                      print(locations.last.longitude);
                    },
                    title: Text(placesLists[index]['description']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
