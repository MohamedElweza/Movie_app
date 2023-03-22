import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cut/API/models/MoviesList.dart';
import 'package:cut/Local/fav_sqlite/Save_sql.dart';
import 'package:cut/Local/fav_sqlite/dbHelper_Save.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Provider/provider.dart';

class Details extends StatefulWidget {
  Details(this.moveDetails, {Key? key}) : super(key: key);
  Movie moveDetails;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late String id;
  late YoutubePlayerController _controller;
  final Duration duration = const Duration(milliseconds: 800);
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    id = widget.moveDetails.id;
    _controller = YoutubePlayerController(initialVideoId: convertUrl(widget.moveDetails.trailer));
  }

  @override
  void dispose() {
    _controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text(
            'Details Movie',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                toggle = !toggle;
                Provider.of<MyProvider>(context, listen: false).SaveIconChange(toggle);
                if(toggle == false){
                SaveDB.instance.delete(widget.moveDetails.id);
                }else{
                  SaveDB.instance.insertSave(
                    Save(
                      id: widget.moveDetails.id,
                      title: widget.moveDetails.title,
                      image: widget.moveDetails.image,
                      genre: widget.moveDetails.genre.first,
                      trailer: widget.moveDetails.trailer,
                      rating: widget.moveDetails.rating,
                      year: widget.moveDetails.year,
                    ),
                  );
                }
              },
              icon: Icon(
                  Provider.of<MyProvider>(context).IconColor,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 25, left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                            height: 350,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(.8),
                                    BlendMode.dstATop),
                                image: NetworkImage(
                                  widget.moveDetails.image,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 105.0),
                      child: Text(
                        widget.moveDetails.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 14.0, top: 12, bottom: 5),
                      child: Row(
                        children: [
                          Text(
                            'Director: ${widget.moveDetails.director.first} | ${widget.moveDetails.rating}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Divider(),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 1),
                      child: Row(
                        children: [
                          Container(
                            width: 55,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff373a4f)),
                            child: Center(
                                child: Text(
                              widget.moveDetails.genre.first,
                              style: Theme.of(context).textTheme.bodySmall,
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 45,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff373a4f)),
                            child: Center(
                                child: Text(
                              widget.moveDetails.year.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            )),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.redAccent[200],
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250.0, top: 5),
                      child: Text(
                        'Description:',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, right: 8.0, left: 13, bottom: 8),
                        child: Text(
                          widget.moveDetails.description,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 630,
              right: 130,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffE72626), // Background color
                ),
                onPressed: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'Trailer',
                      pageBuilder: (context, _, __) => FadeInUp(
                        duration: duration,
                        delay: const Duration(milliseconds: 600),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30.0, left: 30.0, top: 150, bottom: 150),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                                child: Scaffold(
                                  body: Container(
                                    color: Color(0xff191A32),
                                    child: Center(
                                      child: YoutubePlayerBuilder(
                                        player: YoutubePlayer(
                                          controller: _controller,
                                        ),
                                        builder: (context, player) {
                                          return YoutubePlayer(controller: _controller);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                                right: 0,
                                left: 0,
                                bottom: 140,
                                child: CircleAvatar(radius: 16, backgroundColor: Colors.white,child: Icon(Icons.close, color: Colors.red,), )
                            ),
                          ]
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffE72626),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text('Watch Trailer',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

String convertUrl(url){
  return YoutubePlayer.convertUrlToId(url).toString();
}
