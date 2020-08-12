import 'package:flutter/material.dart';

const String imageUrl =
    "https://lawyerlearnsblockchain.com/wp-content/uploads/2019/01/GitHub-brave-hed-796x418.jpg";

class JobCard extends StatelessWidget {
  const JobCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    imageUrl,
                    height: double.infinity,
                    width: 110,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        width: 230,
                        child: Text(
                          "Software Developer ",
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        width: 230,
                        child: Text(
                          "PostaPost ",
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.date_range),
                          Container(
                            padding: EdgeInsets.all(6),
                            width: 200,
                            child: Text(
                              "2010/09/31 ",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          Container(
                            padding: EdgeInsets.all(6),
                            width: 100,
                            child: Text(
                              "Amman ",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: RaisedButton(
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              onPressed: () => null,
                              elevation: 1,
                              color: Colors.green[300],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class Stackkk extends StatelessWidget {
  const Stackkk({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment.centerRight,
        child: Stack(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Text(
                        //     "Hello",
                        //     style: TextStyle(
                        //         fontFamily: 'Gilroy',
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 30),
                        //   ),
                        // ),
                        Image.network(
                          imageUrl,
                          height: 50,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15.0),
                    //   child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Icon(
                    //         Icons.add_call,
                    //         color: Colors.black,
                    //         size: 40,
                    //       )),
                    // ),
                  ],
                ))
          ],
        ),
      )
    ]);
  }
}
