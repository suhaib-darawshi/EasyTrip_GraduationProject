import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 10),
          child: Icon(Icons.menu ,color: Colors.black,),

          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:15),
            child: Text("Travel Blog",style: TextStyle(fontSize: 36),),
          ),
          Expanded(child: Placeholder(),flex: 2,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Most Popular",style: TextStyle(fontSize: 20),),
                Text("View All",style: TextStyle(fontSize: 16,color: Colors.deepOrange),)
              ],
            ),
            
          ),
          Expanded(child: Placeholder(),flex:1)

        ],
      ),
    );
  }
}