import 'package:flutter/material.dart';
import 'package:telsavideo/components/core.dart';
import 'dart:convert';
//import 'package:open_file/open_file.dart';
import 'package:share/share.dart';

class DownloadsScreen extends StatefulWidget {
  @override
  DownloadsScreenState createState() => new DownloadsScreenState();
}

class DownloadsScreenState extends State<DownloadsScreen> {
  @override
  void initState() {
    super.initState();
  }

  var reload;

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: retrieveDataMap("downloads"), // a Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: new Text('No connection...'));
            case ConnectionState.waiting:
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new CircularProgressIndicator(),
              ));
            default:
              if (snapshot.hasError)
                return Center(child: new Text('Error: ${snapshot.error}'));
              if (snapshot.data == null || !(snapshot.data.length > 0))
                return Center(child: Text("No Downloads yet."));
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    try {
                      var _data = json.decode(snapshot.data[index]);
                      return ListTile(
                        leading: Icon(Icons.file_download),
                        title: Text(_data["name"].replaceAll(".mp4", "")),
                        subtitle: Text((_data["name"].contains(".mp4")
                                ? "Video"
                                : "Audio") +
                            " - " +
                            _data["size"]),

                        /*Text((_data["name"].contains(".mp4") ? "Video" : "Audio") +
                            " - " +
                            (int.parse(_data["size"]) / 1000000).round().toString() +
                            " MB on Disk"),*/
                        onTap: () {
                          print("pressed");
                          //OpenFile.open(_data["path"]);
                        },
                        onLongPress: () {
                          Share.share(_data["url"]);
                        },
                        trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () async {
                              List<String> _temp =
                                  await retrieveDataMap("downloads");
                              _temp.remove(snapshot.data[index]);
                              saveDataMap("downloads", _temp);
                              setState(() {
                                reload = true;
                              });
                            }),
                      );
                    } catch (e) {
                      print(e);
                    }
                    return ListTile();
                  });
            //_temp.add({"url": videoController.dataSource, "name": filename, "path": directory.path + "/Download/" + filename, "size": size});
            //saveDataMap("downloads", _temp);
          }
        });
  }
}
