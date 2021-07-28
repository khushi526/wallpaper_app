import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/widgets/widgets.dart';

import 'data.dart';
import 'home.dart';
import 'model/wallpaperdata.dart';

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({this.categorieName});
  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallPaper> wallpapers=new List();
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
    getSearchWallPapers(widget.categorieName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              SizedBox(height: 16.0,),
          WallpapersList(wallpaper: wallpapers,context: context),
        ],),
      ),
    ),
    );
  }
}
