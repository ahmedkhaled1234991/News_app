import 'package:flutter/material.dart';
import 'package:news_app/Screens/CategoryScreen.dart';

class CategoriesButton extends StatelessWidget {

  //properties of CategoriesButton
  String? textCategories;
  String? categories;
  Color? colorButton;

  //CategoriesButton constructor
  CategoriesButton({this.textCategories, this.categories, this.colorButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      //show categories buttons on screen
      child: RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen("$categories")));
            print("$categories");
          },
          child: Text(
          "$textCategories",
        style: TextStyle(
          color: Colors.white
        ),
      ),
        color: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
        ),
      ),
    );
  }
}
