import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/garden_data_model.dart';
import '../../models/library_data_model.dart';
import '../../models/playground_data_model.dart';
import '../../models/recreation_data_model.dart';

import '../../models/swimming_data_model.dart';
import '../../models/venue_data_model.dart';
import 'app_url.dart';

class StatesServices {
  Future<PlaygroundDataModel> fetchPlaygroundData() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.playgroundApi,
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      PlaygroundDataModel dataModel = PlaygroundDataModel.fromJson(data);

      return dataModel;
    } else {
      throw Exception('Error');
    }
  }

  Future<SwimmingDataModel> fetchSwimmingPoolData() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.swimmingPoolApi,
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      SwimmingDataModel dataModel = SwimmingDataModel.fromJson(data);

      return dataModel;
    } else {
      throw Exception('Error');
    }
  }

  Future<GardenDataModel> fetchGardenData() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.communityGardensApi,
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      GardenDataModel dataModel = GardenDataModel.fromJson(data);
      return dataModel;
    } else {
      throw Exception('Error');
    }
  }

  Future<LibraryDataModel> fetchLibraryData() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.librariesApi,
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      LibraryDataModel dataModel = LibraryDataModel.fromJson(data);
      return dataModel;
    } else {
      throw Exception('Error');
    }
  }

  Future<VenueDataModel> fetchVenueData() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.venuesApi,
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      VenueDataModel dataModel = VenueDataModel.fromJson(data);
      return dataModel;
    } else {
      throw Exception('Error');
    }
  }

  Future<RecreationDataModel> fetchRecreationData() async {
    final response = await http.get(
      Uri.parse(
        AppUrl.recreationApi,
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      RecreationDataModel dataModel = RecreationDataModel.fromJson(data);
      return dataModel;
    } else {
      throw Exception('Error');
    }
  }
}
