import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Here we code the Drawer Screen

// For launching links
dynamic _launchURL() async {
  final url = 'https://github.com/MohamedMoaayed/Jorbs';
  if (await canLaunch(url)) {
    await launch(
      url,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class AboutDrawer extends StatelessWidget {
  const AboutDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Center(
              child: Text(
                'About the App',
                style: TextStyle(
                    fontFamily: 'Giloary',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Jorbs is a Mobile application Powered By Flutter that helps Users to find jobs from Github Jobs and USAJOBS ( Other Providers will be added soon).',
                style: TextStyle(
                    fontFamily: 'Giloary',
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
                textAlign: TextAlign.left,
                maxLines: 6,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Find the open source Project on GitHub :',
                style: TextStyle(
                    fontFamily: 'Giloary',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                textAlign: TextAlign.left,
                maxLines: 6,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Material(
                child: InkWell(
              onTap: () => _launchURL(),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    'https://miro.medium.com/max/796/1*WY7ELhXIVxbGlUwmhA1PSw.jpeg',
                    width: 120.0,
                    height: 150.0,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
