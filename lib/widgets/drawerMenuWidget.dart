import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 90.0,
            child: DrawerHeader(
              child: Text('Acerca de la app.',
                  style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/banner.gif"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 200),
          Image(
            image: AssetImage("assets/img/manguLogo.png"),
            height: 100.0,
            // fit: BoxFit.cover,
          ),
          SizedBox(height: 200),
          ListTile(
            leading: Icon(Icons.store),
            title: Text("Más aplicaciones"),
            onTap: () async {
                await launch("https://mangugames.netlify.app/");
              // Navigator.pop(context);
              // Navigator.pushNamed(context, SettingsPage.routeName);
              // Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
