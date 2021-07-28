import 'dart:html';
import'package:flutter/material.dart';
import 'package:wallpaperapp/image_view.dart';
import '../model/wallpaperdata.dart';
Widget brandName(){
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      //text:'',
      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
      children: const <TextSpan>[
        TextSpan(text: 'WallPaper', style: TextStyle(color: Colors.black87)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),

      ],
    ),
  );
//    Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: [
//      Text("WallPaper",
//      style: TextStyle(color: Colors.black),),
//      Text("Hub",
//      style: TextStyle(color: Colors.blue),),
//    ],
//  );
}
Widget WallpapersList({List<WallPaper> wallpaper,context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
    childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpaper.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(
                imageUrl: wallpaper.src.portrait,
              )));
            },
            child: Hero(
              tag:wallpaper.src.portrait ,
              child: Container(

              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(wallpaper.src.portrait,
                fit: BoxFit.cover,),
              ),

        ),
            ),
          ),);
      }).toList(),
    ),
  );
}