import 'package:demo/User_Interface/widgets/SearchWdget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class SearchScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchWidget());
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Container(
                  width: MediaQuery.of(context).size.width/4,
                  child: Row(
                    children: [
                      Text("Search".tr()),
                      SizedBox(width: 20.w,),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
                
                ),
                Expanded(
                  child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(Provider.of<AppProvider>(context, listen: false)
                  .defaultTrips[index]
                  .name),
                          );
                        },
                        separatorBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              color: Colors.black,
                            ),
                          );
                        }),
                        itemCount: Provider.of<AppProvider>(context).defaultTrips.length),
                )

          ],
        ),
      ),
    );
  }
}
