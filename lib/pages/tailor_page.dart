import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:service/pages/date_time.dart';

class TailorPage extends StatefulWidget {
  const TailorPage({Key? key}) : super(key: key);

  @override
  State<TailorPage> createState() => _TailorPageState();
}

class _TailorPageState extends State<TailorPage> {
  final List<dynamic> _works = [
    ['Blouse Stitch', 'assets/images/blouse.jpeg', Colors.purple, 0],
    ['Pant Alter', 'assets/images/pant.png', Colors.red, 0],
    ['Shirt Stitch', 'assets/images/shirt.png', Colors.blue, 0],
    ['Suit Tailor', 'assets/images/suit.png', Colors.green, 0],
  ];

  final List<int> _selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _selected.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DateAndTime())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${_selected.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_ios, size: 18),
                ],
              ),
            )
          : null,
      body: _buildBody('Which tailoring \nservice you need?', _works),
    );
  }

  Widget _buildBody(String title, List list) => NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(
            child: FadeInUp(
              child: Padding(
                padding: const EdgeInsets.only(top: 120, right: 20, left: 20),
                child: Text(title,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900)),
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, i) => FadeInUp(
              delay: Duration(milliseconds: 400 * i),
              child: _itemTile(list, i),
            ),
          ),
        ),
      );

  Widget _itemTile(List list, int i) {
    final item = list[i];
    return GestureDetector(
      onTap: () => setState(() {
        _selected.contains(i) ? _selected.remove(i) : _selected.add(i);
      }),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _selected.contains(i)
              ? item[2].shade50.withOpacity(0.5)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(item[1], width: 40, height: 40),
            const SizedBox(width: 12),
            Text(item[0],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Spacer(),
            if (_selected.contains(i))
              const Icon(Icons.check_circle, color: Colors.green)
          ],
        ),
      ),
    );
  }
}
