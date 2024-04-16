import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:pixeltrue/api/response_models/MovieNameListModel.dart';
import 'package:pixeltrue/api/response_models/nodel.dart';
import 'api/ApiClient.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> imagesList = [
    imageForList(),
    imageForList(),
    imageForList(),
    imageForList(),
    imageForList(),
    imageForList(),
    imageForList(),
  ];
  // Future<List<Results>> fetchTrendingData() async {
  //   try {
  //     List<Results> trendingData = await ApiClient.apiTrendingDataList();
  //           final List<String> posterPathList = trendingData.map((result) => result.posterPath ?? '').toList();
  //     return posterPathList;
  //   } catch (error) {
  //     print('Error fetching trending data: $error');
  //   }
  //   return [];
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(61, 54, 80, 0.8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/ic_person_profile.svg"),
                        GestureDetector(
                          onTap: () {
                            // print(apiDataList());
                            //  _showAlertDialog(context, apiDataList());
                          },
                          child: const SizedBox(
                              height: 70,
                              width: 150,
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/netflix_logo.png"))),
                        ),
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const DefaultTabController(
                    length: 2,
                    animationDuration: Duration(milliseconds: 300),
                    child: SizedBox(
                      width: 250,
                      child: TabBar(
                        tabs: [
                          Tab(
                            text: "Movies",
                          ),
                          Tab(
                            text: "Tv Shows",
                          ),
                        ],
                        labelStyle: TextStyle(fontSize: 20),
                        indicatorColor: Colors.white,
                        indicatorWeight: 3.0,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15),
                child: Text(
                  "Genres",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                child: FutureBuilder<List<Genres>>(
                  future: ApiClient.movieNameList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final List<Genres> apiList = snapshot.data!;
                      final List<String> apiMovieNameList =
                          apiList.map((e) => e.name ?? "").toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: apiList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 15,
                              width:
                                  (apiMovieNameList[index].length * 8.0) + 20.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(70, 63, 91, 0.8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  apiMovieNameList[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15),
                child: Text(
                  "Trending",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 140,
                child: FutureBuilder<List<String>>(
                  future: ApiClient.coverApiImages(), // Call your API function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                            'Error: ${snapshot.error}'), // Show error message if an error occurs
                      );
                    } else {
                      // Extract the full image path list from the snapshot data
                      final List<String> coverApiImages = snapshot.data!;
                      final List<String> apiMovieNameList =
                          coverApiImages.map((e) => e ?? "").toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coverApiImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 210,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            70, 63, 91, 0.8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          coverApiImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          "Your Text Here", // Replace this with your desired text
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15),
                child: Text(
                  "Popular",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 170,
                child: FutureBuilder<List<Results>>(
                  future: ApiClient.apiTrendingDataList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final List<Results> fullImagePathList = snapshot.data!;
                      final List<String> imgList = fullImagePathList
                          .map((e) => e.posterPath ?? "")
                          .toList();
                      // final List<String> titles =
                      // imgList.map((e) => e.title ?? "").toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(70, 63, 91, 0.8),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imgList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              // SizedBox(
              //   height: 170,
              //   child: FutureBuilder<List<Results>>(
              //     future: apiTrendingDataList(), // Call your API function
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(
              //           child:
              //               CircularProgressIndicator(), // Show loading indicator while data is fetched
              //         );
              //       } else if (snapshot.hasError) {
              //         return Center(
              //           child: Text(
              //               'Error: ${snapshot.error}'), // Show error message if an error occurs
              //         );
              //       } else {
              //         // Extract the full image path list from the snapshot data
              //         final List<Results> fullImagePathList = snapshot.data!;
              //         final List<String> imgList = fullImagePathList
              //             .map((e) => e.backdropPath ?? "")
              //             .toList();
              //         final List<String> titles =
              //             fullImagePathList.map((e) => e.title ?? "").toList();
              //         return ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: fullImagePathList.length,
              //           itemBuilder: (context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.all(5.0),
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     width: 120,
              //                     height: 160,
              //                     decoration: BoxDecoration(
              //                       color:
              //                           const Color.fromRGBO(70, 63, 91, 0.8),
              //                       borderRadius: BorderRadius.circular(15),
              //                     ),
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(12),
              //                       child: Image.network(
              //                         imgList[index],
              //                         // Load image from the fullImagePathList
              //                         fit: BoxFit
              //                             .cover, // Adjust image fit as needed
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
              // ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15),
                child: Text(
                  "Now Playing",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 170,
                child: FutureBuilder<List<String>>(
                    future: ApiClient.nowPlayingResponse(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final List<String> imageUrls = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 120,
                                  // width: (countries[index].length * 8.0) + 20.0,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(70, 63, 91, 0.8),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageUrls[index],
                                      // Load image from the fullImagePathList
                                      fit: BoxFit
                                          .cover, // Adjust image fit as needed
                                    ),
                                  ),
                                ));
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

apiImageList() {
  return ClipRRect(
    child: Image.network("apiDataList"),
  );
}

imageForList() {
  return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image(
        image: AssetImage("assets/images/popcorn.jpg"),
        fit: BoxFit.cover,
      ));
}
