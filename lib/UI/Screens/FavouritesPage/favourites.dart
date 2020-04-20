import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/FavouritesPage/pageBody.dart';

class Favourites extends StatefulWidget {
  @override
  FavouriteState createState() => FavouriteState();
}

class FavouriteState extends State<Favourites>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                background: headerTitle(context),
              ),
              floating: true,
              pinned: true,
              snap: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(55),
                child: Container(
                    color: Colors.white,
                    child: TabBar(
                        tabs: <Tab>[
                          Tab(text: "Favourited"),
                          Tab(text: "Registered"),
                        ],
                        controller: _tabController,
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: pfontFamily,
                        ),
                        labelColor: primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: primaryColor,
                        indicatorSize: TabBarIndicatorSize.label)),
              ),
            )
          ];
        },
        body: TabBarView(controller: _tabController, children: <Widget>[
          FavouritesList('Competitions'),
          FavouritesList('Competitions')
        ]),
      ),
    );
  }

  headerTitle(BuildContext context) {
    double fontSize = 24;
    var fontWeight = FontWeight.w700;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Favourites",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: primaryColor,
                fontFamily: pfontFamily,
              )),
          headingIcons(context)
        ],
      ),
    );
  }

  headingIcons(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          iconSize: 28,
          color: primaryColor,
          onPressed: () {},
        )
      ],
    );
  }

  customAppBar() {
    return PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0));
  }
}
