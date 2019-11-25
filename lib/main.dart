import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:laravelvideo/videoslist.dart';
import 'package:flutube/flutube.dart';



void main() => runApp(

  MaterialApp(
    home: MyApp(),
  )
);



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red,
    ));
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5852042324891789~1535902166");
    myBanner
    // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
    return Scaffold(
        drawer: Drawer(),
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  backgroundColor: Colors.red,
                  title: Text('Video Tutorial Laravel 6'),
                )
              ];
            },
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemCount: videoslist.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Image.network('https://img.youtube.com/vi/${videoslist[i].id}/hqdefault.jpg'),
                        title: Text(videoslist[i].title),
                        subtitle: Text(videoslist[i].subtitle),
                        trailing: Icon(Icons.remove_red_eye),
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context)=> VideoPlay(
                                  url: 'https://www.youtube.com/watch?v=${videoslist[i].id}',
                                  title: videoslist[i].title,
                                )
                              )
                          );
                        }
                      );
                    },
                  ),
                )
              ],
            )
        )
    );
  }
}
//
//
class VideoPlay extends StatelessWidget {
  final String url;
  final String title;
  VideoPlay({this.url, this.title});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.red,
      ),
      body: FluTube(
        url,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
        onVideoStart: () {},
        onVideoEnd: () {},
        deviceOrientationAfterFullscreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
        systemOverlaysAfterFullscreen: SystemUiOverlay.values,
      ),
    );
  }


}


// Admob
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-5852042324891789/6596657151",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-5852042324891789/7020001432",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);