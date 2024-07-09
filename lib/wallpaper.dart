import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:screen_jewel/fullscreen.dart";

class WallpaperHome extends StatefulWidget {
  WallpaperHome({super.key});

  @override
  State<WallpaperHome> createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          "Authorization":
              "XtavE9Z0ILA95ENdqIY8zVYqD8Gy3QWlyQvANOF26bvdqDu7pjs34S1s"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images);
    });
  }

  loadmore() async {
    setState(() {
      page = page + 1;
    });
    String url =
        "https://api.pexels.com/v1/curated?per_page=80&page=" + page.toString();
    await http.get(Uri.parse(url), headers: {
      "Authorization":
          "XtavE9Z0ILA95ENdqIY8zVYqD8Gy3QWlyQvANOF26bvdqDu7pjs34S1s"
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result["photos"]);
      });
    });
  }

  Widget build(context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Container(
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                      imageurl: images[index]["src"]
                                          ["large2x"])));
                        },
                        child: Container(
                          color: Colors.grey,
                          child: Image.network(images[index]["src"]["tiny"],
                              fit: BoxFit.cover),
                        ),
                      );
                    }))),
        InkWell(
          onTap: () {
            loadmore();
          },
          child: Container(
              height: 30,
              width: double.infinity,
              // padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Center(child: Text("Load More"))),
        )
      ],
    ));
  }
}
