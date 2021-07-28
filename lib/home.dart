import 'dart:convert';
//import 'dart:io';
//import 'dart:js';
//import 'dart:typed_data';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaperapp/category.dart';
import 'package:wallpaperapp/data.dart';
//import 'package:wallpaperapp/image_view.dart';
import 'package:wallpaperapp/model/categories_model.dart';
import 'package:wallpaperapp/model/wallpaperdata.dart';
import 'package:wallpaperapp/search.dart';
import 'package:wallpaperapp/widgets/widgets.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories=new List();
  List<WallPaper> wallpapers=new List();
  TextEditingController searchController= new TextEditingController();
  getTrendingWallPapers() async{
    var response=await http.get("https://api.pexels.com/v1/curated?per_page=15&page=1",
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
    getTrendingWallPapers();
    categories=getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(
                        searchQuery: searchController.text,
                      )),);
                    },
                    child: Container(
                        child: Icon(Icons.search)),
                  ),
                ],),
              ),
              SizedBox(height: 16.0,),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imageUrl: categories[index].imgUrl,
                    );
                    }),
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
class CategoriesTile extends StatelessWidget {
  final String imageUrl,title;
  CategoriesTile({@required this.imageUrl,@required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Categorie(
          categorieName: title.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrl,
              height: 50,
              width: 100,
              fit: BoxFit.cover,),
            ),
            Container(
              //color: Colors.black26,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),),
            ),
          ],
        ),
      ),
    );
  }

}
