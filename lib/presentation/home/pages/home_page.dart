import 'package:flutter/material.dart';
import 'package:steet/presentation/widgets/rooms_list_1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // padding: EdgeInsets.only(  
        //   left: 10,
        //   right: 10,
        // ),
        child: Column(
          children: [
            RoomsList1(categoryTitle: "🔥 Populare Rooms", itemCount: 3, itemLabelBuilder: (index) {
              return "Room Name $index";
            }),
            const SizedBox(height: 10),
            RoomsList1(categoryTitle: "Public Rooms", itemCount: 3, itemLabelBuilder: (index) {
              return "Room Name $index";
            }),
            const SizedBox(height: 10),
            RoomsList1(categoryTitle: "Private Rooms", itemCount: 3, itemLabelBuilder: (index) {
              return "Room Name $index";
            }),
          ],
        ),
      ),
    );
  }
}