import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/Services/Api.dart';
import 'package:news_app/Services/fun.dart';
import 'package:news_app/widgets/CategoriesButton.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import '../constant.dart';

class CategoryScreen extends StatefulWidget {
  //category variable
  String category;

  //CategoryScreen constructor
  CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //api object from Api class
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30),
            child: ListTile(
              title: Text(
                "${widget.category} Category News",
                style: TextStyle(
                  color: textColor,
                  fontSize: fontlarge,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              //show news category on screen
              child: FutureBuilder(
                future: api.fetchArticlesByCategory(widget.category),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Fun.openLink("${snapshot.data[i].url}");
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 5.0,
                              child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25.0),
                                          topLeft: Radius.circular(25.0)),
                                      child: Image.network(
                                        //if image equal null show error 404 image
                                        (snapshot.data[i].urlToImage == null)
                                            ? "https://www.seo-stars.com/wp-content/uploads/2020/05/404-ERROR-PAGE.jpg"
                                            : snapshot.data[i].urlToImage,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text(
                                        "${snapshot.data[i].title}",
                                        style: TextStyle(
                                            fontSize: fontSubTitle,
                                            fontWeight: FontWeight.w800),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Divider(
                                      height: 25,
                                      color: Colors.black,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.only(
                                              left: 60.0, bottom: 5.0),
                                          onPressed: () {
                                            //call shareLink function
                                            Fun.shareLink(
                                                "${snapshot.data[i].url}");
                                          },
                                          icon: Icon(Icons.share),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.only(
                                              left: 220.0, bottom: 5.0),
                                          onPressed: () {
                                            //call copyLink function
                                            Fun.copyLink(
                                                "${snapshot.data[i].url}");
                                            final snackBar = SnackBar(
                                                content: Text(
                                                    'copied to clipboard'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          icon: Icon(Icons.copy),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: yellow,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
