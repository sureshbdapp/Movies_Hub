import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pixeltrue/api/response_models/MovieNameListModel.dart';
import 'package:pixeltrue/api/response_models/nodel.dart';

String apiKey = 'fafacb4ff62a439a88f32231bd112ec5';
String baseUrl = "https://api.themoviedb.org/3";
String imageBaseUrl = "https://image.tmdb.org/t/p/w500/";
String endpoint = "/trending/movie/day";
String loginBaseUrl = "https://dummyjson.com/auth/login";

class ApiClient {
  static Future<List<Results>> apiTrendingDataList() async {
    final url = Uri.parse("$baseUrl$endpoint?api_key=$apiKey");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> resultsData = responseData['results'];
        final List<Results> resultsList =
            resultsData.map((data) => Results.fromJson(data)).toList();
        return resultsList;
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
        throw Exception('Failed to load data');
      }
    } catch (error) {
      if (kDebugMode) {
        print('An error occurred: $error');
      }
      throw Exception('Failed to load data');
    }
  }

  static Future<List<Results>> coverApiImages() async {
    final url = Uri.parse("$baseUrl$endpoint?api_key=$apiKey");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> resultsData = responseData['results'];
        final List<Results> apiResultResponse =
            resultsData.map((data) => Results.fromJson(data)).toList();
        // final List<String> posterPathList =
        //     resultsList.map((result) => result.backdropPath ?? '').toList();
        //
        // final List<String> fullImagePathList = posterPathList
        //     .map((path) => 'https://image.tmdb.org/t/p/w500/$path')
        //     .toList();
        if (kDebugMode) {
          print('Poster Path List: $apiResultResponse');
        }

        return apiResultResponse;
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print('An error occurred: $error');
      }
      return [];
    }
  }

  static Future<List<Genres>> movieNameList() async {
    final url = Uri.parse("$baseUrl/genre/movie/list?api_key=$apiKey");
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body);
        final List<dynamic> keyPoint = list["genres"];
        final List<Genres> genList =
            keyPoint.map((result) => Genres.fromJson(result)).toList();

        return genList;
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }
    return [];
  }

//NOW PLAYING RESPONSE
  static Future<List<String>> nowPlayingResponse() async {
    final apiUrl = Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey");
    final response = await http.get(apiUrl);
    try {
      if (response.statusCode == 200) {
        final apiResponse = jsonDecode(response.body);
        final List<dynamic> getApiList = apiResponse["results"];
        final List<Results> responseResult =
            getApiList.map((e) => Results.fromJson(e)).toList();
        final List<String> imageUrls =
            responseResult.map((e) => e.backdropPath ?? "").toList();
        final List<String> apiImagesUrls = imageUrls
            .map((path) => 'https://image.tmdb.org/t/p/w500/$path')
            .toList();
        return apiImagesUrls;
      } else {}
    } catch (error) {
      print('An error occurred: $error');
    }
    return [];
  }

  static Future<String> loginApi(Map<String, String> map) async {
    final url = Uri.parse(loginBaseUrl);
    final httpResponse = await http.post(url, body: map);
    try {
      if (httpResponse.statusCode == 200) {
        final apiResponse = jsonDecode(httpResponse.body);
        final String userName = apiResponse["firstName"];
        print(userName);
        return userName;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}
