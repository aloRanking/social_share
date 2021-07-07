import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    downloadFile();
    super.initState();
    initPlatformState();
  }

  void downloadFile() async {
    var filei = await urlToFile('https:\/\/ttrconsult.com.ng\/api\/pay\/campaign\/137\/60e0133b8a28a.mp4', 'video');

    file = filei;
  }

  Future<File> urlToFile(String imageUrl, String mediaType) async {
    File file;
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    if (mediaType == 'image') {
      file =
      new File('$tempPath' + '/' + (rng.nextInt(100)).toString() + '.png');
    } else {
      file =
      new File('$tempPath' + '/' + (rng.nextInt(100)).toString() + '.mp4');
    }

// call http.get method and pass imageUrl into it to get response.
    var response = await Dio().get(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    // http.Response response = await http.get(imageUrl);
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.data);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    print('downloaded');
    return file;
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  File file;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Running on: $_platformVersion\n',
                  textAlign: TextAlign.center,
                ),
            RaisedButton(
              onPressed: () async {
                SocialShare.shareInstagramFeed(file.path,
                  contentURL:"Hello World \n https://google.com",
                ).then((data) {
                  print(data);
                });
              },
              child: Text("Share on Instagram"),),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareWhatsapp(file.path,
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on WhatsApp"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareWhatsapp(file.path,
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on WhatsApp"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareTwitter( file.path,
                      "This is Social Share twitter example",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on twitter"),
                ),
                RaisedButton(
                  onPressed: () async {
                    File file = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    SocialShare.shareInstagramStory(
                      file.path,
                      backgroundTopColor: "#ffffff",
                      backgroundBottomColor: "#000000",
                      attributionURL: "https://deep-link-url",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share On Instagram Story"),
                ),

                ElevatedButton(onPressed: (){
                  SocialShare.shareFacebookFeed(file.path, 'what up');

                }, child: Text('FaceBook')),
               /* RaisedButton(
                  onPressed: () async {
                    SocialShare.shareTwitter( file.path,
                      "This is Social Share twitter example",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on twitter"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await screenshotController.capture().then((image) async {
                      SocialShare.shareInstagramStory(
                        image.path,
                        backgroundTopColor: "#ffffff",
                        backgroundBottomColor: "#000000",
                        attributionURL: "https://deep-link-url",
                        backgroundImagePath: image.path,
                      ).then((data) {
                        print(data);
                      });
                    });
                  },
                  child: Text("Share On Instagram Story with background"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await screenshotController.capture().then((image) async {
                      //facebook appId is mandatory for andorid or else share won't work
                      Platform.isAndroid
                          ? SocialShare.shareFacebookStory(
                              image.path,
                              "#ffffff",
                              "#000000",
                              "https://google.com",
                              appId: "xxxxxxxxxxxxx",
                            ).then((data) {
                              print(data);
                            })
                          : SocialShare.shareFacebookStory(
                              image.path,
                              "#ffffff",
                              "#000000",
                              "https://google.com",
                            ).then((data) {
                              print(data);
                            });
                    });
                  },
                  child: Text("Share On Facebook Story"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.copyToClipboard(
                      "This is Social Share plugin",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Copy to clipboard"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareTwitter(
                      "This is Social Share twitter example",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on twitter"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareSms(
                      "This is Social Share Sms example",
                      url: "\nhttps://google.com/",
                      trailingText: "\nhello",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Sms"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await screenshotController.capture().then((image) async {
                      SocialShare.shareOptions("Hello world").then((data) {
                        print(data);
                      });
                    });
                  },
                  child: Text("Share Options"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareWhatsapp(
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Whatsapp"),
                ),*/
                RaisedButton(
                  onPressed: () async {
                    SocialShare.shareTelegram(
                      "Hello World \n https://google.com",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Telegram"),
                ),
                RaisedButton(
                  onPressed: () async {
                    SocialShare.checkInstalledAppsForShare().then((data) {
                      print(data.toString());
                    });
                  },
                  child: Text("Get all Apps"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
