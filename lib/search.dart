import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/data.dart';
import 'package:wallpaperapp/widgets/widgets.dart';
import 'package:http/http.dart' as http;

import 'model/wallpaperdata.dart';
class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallPaper> wallpapers=new List();
  TextEditingController searchController= new TextEditingController();
  getSearchWallPapers(String query) async{
    var response=await http.get("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
        headers: {
          "Authorization": apiKEY,
        });
    //print(response.body.toString());
    Map<String,dynamic> jsonData= jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallPaper wallPapermodel=new WallPaper();
      wallPapermodel=WallPaper.fromMap(element);
      wallpapers.add(wallPapermodel);
    });
    setState(() {});
  }
  @override
  void initState() {
    getSearchWallPapers(widget.searchQuery);
    searchController.text=widget.searchQuery;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),

                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search Wallpaper",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      getSearchWallPapers(searchController.text);
                    },
                    child: Container(
                        child: Icon(Icons.search)),
                  ),
                ],),
              ),
              SizedBox(height: 16.0,),
              WallpapersList(wallpaper: wallpapers,context: context),
            ],
          ),
        ),
      ),
    );
  }
}
