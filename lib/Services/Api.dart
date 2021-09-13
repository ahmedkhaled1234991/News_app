import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:news_app/models/Article.dart';

class Api{

  final String apiKey = "cf8c972fde0a4129a4868d7cf5ced940";
  //fetchArticles function to get data from api
  Future<List<Article>>fetchArticles() async {
    //url variable to go to news address
    var url = Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&apiKey=$apiKey');
    //response to retrieve news from server
    var response = await http.get(url);
    //listArticle list to store objects from Article class
    List<Article> listArticle = [];
    //check if response is working
    if (response.statusCode == 200) {
      //return the resulting json object
      var responsebody = jsonDecode(response.body)["articles"];
      //for loop to get responsebody
      for(var i in responsebody){
        //article object to get news from responsebody
        Article article = Article(i["title"], i["description"], i["url"], i["urlToImage"]);
        //add objects to listArticle list
        listArticle.add(article);
      }
      return listArticle;
    }
    return listArticle;
  }

  //fetchArticlesByCategory function to get data from api
  Future<List<Article>>fetchArticlesByCategory(String category) async {
    //url variable to go to category news address
    var url = Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$apiKey');
    //response to retrieve category news from server
    var response = await http.get(url);
    //listArticle list to store objects from Article class
    List<Article> listArticle = [];
    //check if response is working
    if (response.statusCode == 200) {
      //return the resulting json object
      var responsebody = jsonDecode(response.body)["articles"];
      //for loop to get responsebody
      for(var i in responsebody){
        //article object to get category news from responsebody
        Article article = Article(i["title"], i["description"], i["url"], i["urlToImage"]);
        //add objects to listArticle list
        listArticle.add(article);
      }
      return listArticle;
    }
    return listArticle;
  }

}