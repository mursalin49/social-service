import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:service/pages/date_time.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  // Rooms to clean
  List<dynamic> _rooms = [
    ['Living Room', 'assets/images/living-room.png', Colors.red, 0],
    ['Bedroom', 'assets/images/bedroom.png', Colors.orange, 1],
    ['Bathroom', 'assets/images/bath.jpg', Colors.blue, 1],
    ['Kitchen', 'assets/images/kitchen.jpg', Colors.purple, 0],
    ['Office', 'assets/images/office.png', Colors.green, 0]
  ];

  List<int> _selectedRooms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _selectedRooms.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DateAndTime()),
                );
              },
              backgroundColor: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedRooms.length}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),
            )
          : null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeInUp(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 120.0, right: 20.0, left: 20.0),
                  child: Text(
                    'Where do you want \ncleaned?',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _rooms.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeInUp(
                  delay: Duration(milliseconds: 500 * index),
                  duration: const Duration(milliseconds: 500),
                  child: room(_rooms[index], index),
                );
              }),
        ),
      ),
    );
  }

  Widget room(List room, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRooms.contains(index)) {
            _selectedRooms.remove(index);
          } else {
            _selectedRooms.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _selectedRooms.contains(index)
              ? room[2].shade50.withOpacity(0.5)
              : Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      room[1],
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      room[0],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Spacer(),
                _selectedRooms.contains(index)
                    ? Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            (_selectedRooms.contains(index) && room[3] >= 1)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      Text("How many ${room[0]}s?",
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int i) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  room[3] = i + 1;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                padding: const EdgeInsets.all(10.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: room[3] == i + 1
                                      ? room[2].withOpacity(0.5)
                                      : room[2].shade200.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    (i + 1).toString(),
                                    style: const TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
