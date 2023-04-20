import 'package:cut/screens/Login&RegisterScreen/Login.dart';
import 'package:cut/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:cut/API/Response.dart';
import 'package:cut/API/models/MainList.dart';
import 'package:cut/API/models/MoviesList.dart';
import 'package:cut/Provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'Details.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          automaticallyImplyLeading: true,
          title: Text(
            'Hi Mohamed!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80'),
              backgroundColor: Color(0xff191A32),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
          child: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Stack(children: const [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg'),
                        radius: 70,
                      ),
                      Positioned(
                        right: 4,
                        top: 10,
                        child: Icon(
                          Icons.edit,
                          color: Colors.red,
                          size: 20,
                        ),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Dark mode',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Switch(
                          value: Provider.of<MyProvider>(context).Value,
                          onChanged: (val) =>
                              Provider.of<MyProvider>(context, listen: false)
                                  .switchChange(val),
                          activeColor: Colors.blueAccent,
                          inactiveThumbColor: Colors.red,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text('Log out',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: const Login(),
                        )),
                  )
                ],
              )),
        ),
        body: FutureBuilder<MainList>(
            future: GetAllMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var Data = snapshot.data!;
                child:
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Theme.of(context).primaryColor,
                              elevation: 5.0,
                              child: TextField(
                                cursorColor: Colors.red,
                                style: const TextStyle(color: Colors.white54),
                                decoration: InputDecoration(
                                  fillColor: Colors.white10,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  prefixIcon: Container(
                                    padding: const EdgeInsets.all(15),
                                    width: 18,
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                              onTap: () {
                                Movie movies =
                                    snapshot.data!.mainData[index + 80];
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: Details(movies)));
                              },
                              child: Card(
                                color: Theme.of(context).cardColor,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 70,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          Data.mainData
                                              .elementAt(index + 80)
                                              .image,
                                          fit: BoxFit.cover,
                                          height: 200,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          Data.mainData
                                              .elementAt(index + 80)
                                              .title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Text(
                                          Data.mainData
                                              .elementAt(index + 80)
                                              .genre
                                              .elementAt(index),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              Data.mainData
                                                  .elementAt(index + 80)
                                                  .rating,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 60.0),
                              child: Text(
                                'Popular',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const Products()),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 60.0),
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                ))
                          ],
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: 10,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                              onTap: () {
                                Movie movies = snapshot.data!.mainData[index];
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: Details(movies)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Image(
                                            image: NetworkImage(
                                              snapshot.data!.mainData
                                                  .elementAt(index)
                                                  .image,
                                            ),
                                          )),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          Data.mainData.elementAt(index).title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Text(
                                          Data.mainData
                                              .elementAt(index)
                                              .genre
                                              .first,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Container(
                  color: Theme.of(context).primaryColor,
                );
              }
              return Container(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              );
            }));
  }
}
