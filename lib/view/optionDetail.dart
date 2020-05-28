import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countingdaysloveyou/global.dart';

class OptionDetail extends StatefulWidget {
  final String title;
  OptionDetail({this.title});
  @override
  _OptionDetailState createState() => _OptionDetailState();
}
final TextStyle _textStyle = TextStyle(fontFamily: 'Rubik', fontSize: 16.0, color: Colors.grey[800]);
class _OptionDetailState extends State<OptionDetail> {
  bool isCheckHeart = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    DocumentSnapshot document = args;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 12.0, right: 12.0, bottom: 8.0, top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.grey[800],
                    iconSize: 30.0,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.blue, fontSize: 30.0),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isCheckHeart = !isCheckHeart;
                      });
                    },
                    icon: Icon(!isCheckHeart ? Icons.favorite_border : Icons.favorite),
                    color: !isCheckHeart ? Colors.grey[800] : Colors.red,
                    iconSize: 30.0,
                  )
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300.0,
                  child: Image.network(
                    document[urlchild],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(1),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 220.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange[100].withOpacity(0.3),
                          offset: Offset(0.0, -10.0),
                          blurRadius: 8.0,
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      document[namechild],
                                      style: _textStyle.copyWith(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      'Acompanhamentos',
                                      style:
                                          _textStyle.copyWith(fontSize: 16.0),
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert,
                                    size: 38.0,
                                    color: Colors.grey[800],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection(keynameItemListCount)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return new Text('Loading...');
                                default:
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Column(
                                      children: List.generate(
                                        snapshot.data.documents.length,
                                        (index) {
                                          DocumentSnapshot document =
                                              snapshot.data.documents[index];
                                          return Row(
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: Image(
                                                  width: 100.0,
                                                  image: NetworkImage(
                                                      document[urlchild]),
                                                ),
                                              ),
                                              SizedBox(width: 25.0),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      document[title],
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Text(
                                                      document[subTitle],
                                                      style:
                                                          _textStyle.copyWith(
                                                              fontSize: 16.0),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30, right: 30.0, top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Pedir',
                                    style: _textStyle.copyWith(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Material(
                                  elevation: 15.0,
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.orange,
                                  shadowColor: Colors.orange.withOpacity(0.6),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    child: Text(
                                      'Faca seu pedido',
                                      style: _textStyle.copyWith(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          buildContent(context)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: Firestore.instance.collection(keynameItemListCount).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CarouselSlider(
                height: width / 2,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                enlargeCenterPage: true,
                items: snapshot.data.documents.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: _buildItem(item[urlchild], item[title]),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }

  _buildItem(String imagePath, String title) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Image.network(
              imagePath,
              fit: BoxFit.cover,
              height: constraints.biggest.height,
              width: constraints.biggest.width,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: constraints.biggest.width,
              height: constraints.biggest.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0x00000000),
                    Color(0x00000000),
                    Color(0x22000000),
                    Color(0x66000000),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title?.toUpperCase() ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli',
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
