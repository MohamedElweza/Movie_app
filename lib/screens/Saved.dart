import 'package:flutter/material.dart';
import 'package:cut/Local/fav_sqlite/dbHelper_Save.dart';

import '../Local/fav_sqlite/Save_sql.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    List<Save> Saves = [];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title:  Text(
            'Saved',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: FutureBuilder<List<Save>>(
          future: SaveDB.instance.getAllSaved(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
          physics: const BouncingScrollPhysics(),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
            Saves =  snapshot.data!;
        return Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child:  Image(
                          fit: BoxFit.fill,
                          height: 150,
                          image: NetworkImage(
                            Saves.elementAt(index).image,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.elementAt(index).title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Divider(),
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data!.elementAt(index).genre,
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      snapshot.data!.elementAt(index).rating,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(onPressed: (){
                              setState(() {
                                SaveDB.instance.delete(snapshot.data!.elementAt(index).id);
                              });

                            }, icon: Icon(Icons.restore_from_trash_sharp, color: Colors.cyan,))
                          ],
                        ),

                        Divider(),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffE72626), // Background color
                              ),
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE72626),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Text('Watch now',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
      }
          ),
        );
      }
      if (snapshot.hasError) {
        print(snapshot.error);
        return Container(
          color: Theme.of(context).backgroundColor,
        );
      }
      return  Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      );
      }
        ),
      ),
    );
  }
}
