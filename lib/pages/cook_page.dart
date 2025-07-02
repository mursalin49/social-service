// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:service/pages/date_time.dart';
//
// class CookPage extends StatefulWidget {
//   const CookPage({Key? key}) : super(key: key);
//
//   @override
//   State<CookPage> createState() => _CookPageState();
// }
//
// class _CookPageState extends State<CookPage> {
//   final List<dynamic> _cookOptions = [
//     ['Daily Meal', 'assets/images/daily_meal.png', Colors.orange, 0],
//     ['Event Catering', 'assets/images/catering.png', Colors.red, 0],
//     ['Special Diet', 'assets/images/diet.jpeg', Colors.teal, 0],
//     ['Bakery Items', 'assets/images/bakery.jpeg', Colors.brown, 0],
//   ];
//
//   final List<int> _selected = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: _selected.isNotEmpty
//           ? FloatingActionButton(
//               backgroundColor: Colors.orange,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const DateAndTime()),
//                 );
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('${_selected.length}',
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(width: 2),
//                   const Icon(Icons.arrow_forward_ios, size: 18),
//                 ],
//               ),
//             )
//           : null,
//       body: _buildBody('What kind of \ncooking service?', _cookOptions),
//     );
//   }
//
//   Widget _buildBody(String title, List list) => NestedScrollView(
//         headerSliverBuilder: (_, __) => [
//           SliverToBoxAdapter(
//             child: FadeInUp(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 120, right: 20, left: 20),
//                 child: Text(title,
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade900,
//                     )),
//               ),
//             ),
//           ),
//         ],
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: list.length,
//             itemBuilder: (_, i) => FadeInUp(
//               delay: Duration(milliseconds: 400 * i),
//               child: _itemTile(list, i),
//             ),
//           ),
//         ),
//       );
//
//   Widget _itemTile(List list, int i) {
//     final item = list[i];
//     return GestureDetector(
//       onTap: () => setState(() {
//         _selected.contains(i) ? _selected.remove(i) : _selected.add(i);
//       }),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 20),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         decoration: BoxDecoration(
//           color: _selected.contains(i)
//               ? item[2].shade50.withOpacity(0.5)
//               : Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Image.asset(item[1], width: 40, height: 40),
//             const SizedBox(width: 12),
//             Text(item[0],
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             const Spacer(),
//             if (_selected.contains(i))
//               const Icon(Icons.check_circle, color: Colors.green),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'ServiceProviderPage.dart';

class CookerPage extends StatelessWidget {
  const CookerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceProviderPage(
      profession: 'Cooker',
      title: 'Available Cookers',
    );
  }
}
