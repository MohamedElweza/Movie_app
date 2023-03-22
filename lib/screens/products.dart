import 'package:cut/API/models/MainList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

import '../API/Response.dart';
import '../API/models/MoviesList.dart';
import 'Details.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            pinned: true,
            floating: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Movies', style: Theme.of(context).textTheme.bodySmall,),
              background: Image.asset('assets/image/mm.png',fit: BoxFit.cover,),

            ),
          ),

          ],
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<MainList>(
                  future: GetAllMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var Data = snapshot.data!;
                      return MasonryGridView.builder(
                          mainAxisSpacing: 7.0,
                          crossAxisSpacing: 4.0,
                          itemCount: snapshot.data!.mainData.length,
                          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            Movie movies = snapshot.data!.mainData[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: Details(movies)));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image(
                                          image: NetworkImage(
                                            snapshot.data!.mainData
                                                .elementAt(index)
                                                .image,
                                          ),
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(Data.mainData.elementAt(index).title,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  ),

                                  SizedBox(height: 4),
                                  Text(Data.mainData.elementAt(index).genre.first,
                                    style: Theme.of(context).textTheme.titleSmall,),
                                ],
                              ),
                            );
                          });
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container(
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }),
          ),
        ),

      ),
    );
  }
}
