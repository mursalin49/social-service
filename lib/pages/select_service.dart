// import 'package:flutter/material.dart';
// import 'package:service/models/service.dart';
// import 'package:service/pages/cleaning.dart';
// import 'package:animate_do/animate_do.dart';
//
// class SelectService extends StatefulWidget {
//   const SelectService({Key? key}) : super(key: key);
//
//   @override
//   _SelectServiceState createState() => _SelectServiceState();
// }
//
// class _SelectServiceState extends State<SelectService> {
//   List<Service> services = [
//     Service('Cleaning', 'assets/images/clean.png'),
//     Service('Electrician', 'assets/images/electri.png'),
//     Service('Tailor', 'assets/images/tailor.png'),
//     Service('CareTaker', 'assets/images/care.jpg'),
//     Service('Driver', 'assets/images/driver.png'),
//     Service('Cook', 'assets/images/cooker.png'),
//   ];
//
//   int selectedService = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: selectedService >= 0
//           ? FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CleaningPage()),
//                 );
//               },
//               backgroundColor: Colors.blue,
//               child: Icon(Icons.arrow_forward_ios, size: 20),
//             )
//           : null,
//       body: NestedScrollView(
//         headerSliverBuilder: (context, _) => [
//           SliverToBoxAdapter(
//             child: FadeInUp(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
//                 child: Text(
//                   'Which service \ndo you need?',
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.grey.shade900,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//         body: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1.0,
//                     crossAxisSpacing: 20.0,
//                     mainAxisSpacing: 20.0,
//                   ),
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: services.length,
//                   itemBuilder: (context, index) {
//                     return FadeInUp(
//                       delay: Duration(milliseconds: 500 * index),
//                       child: serviceContainer(
//                         services[index].imageURL,
//                         services[index].name,
//                         index,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget serviceContainer(String imagePath, String name, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedService = (selectedService == index) ? -1 : index;
//         });
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         padding: EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           color: selectedService == index
//               ? Colors.blue.shade50
//               : Colors.grey.shade100,
//           border: Border.all(
//             color: selectedService == index ? Colors.blue : Colors.transparent,
//             width: 2.0,
//           ),
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(imagePath, height: 80),
//             SizedBox(height: 20),
//             Text(name, style: TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:service/models/service.dart';
import 'package:service/pages/cleaning.dart';
import 'package:service/pages/driver_page.dart';
import 'package:service/pages/tailor_page.dart';
import 'package:service/pages/electrician_page.dart';

import 'caretaker_page.dart';
import 'cook_page.dart';

class SelectService extends StatefulWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  List<Service> services = [
    Service('Cleaning', 'assets/images/clean.png'),
    Service('Electrician', 'assets/images/electri.png'),
    Service('Tailor', 'assets/images/tailor.png'),
    Service('CareTaker', 'assets/images/care.jpg'),
    Service('Driver', 'assets/images/driver.png'),
    Service('Cooker', 'assets/images/cooker.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: selectedService >= 0
          ? FloatingActionButton(
              onPressed: () {
                Widget nextPage;

                switch (services[selectedService].name) {
                  case 'Cleaning':
                    nextPage = CleaningPage();
                    break;
                  case 'Driver':
                    nextPage = const DriverPage();
                    break;
                  case 'Tailor':
                    nextPage = const TailorPage();
                    break;
                  case 'Electrician':
                    nextPage = const ElectricianPage();
                    break;
                  case 'CareTaker':
                    nextPage = const CaretakerPage();
                    break;
                  case 'Cooker':
                    nextPage = const CookerPage();
                    break;
                  default:
                    nextPage = CleaningPage(); // Default fallback
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.arrow_forward_ios, size: 20),
            )
          : null,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverToBoxAdapter(
            child: FadeInUp(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'Which service \ndo you need?',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      delay: Duration(milliseconds: 500 * index),
                      child: serviceContainer(
                        services[index].imageURL,
                        services[index].name,
                        index,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceContainer(String imagePath, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedService = (selectedService == index) ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 80),
            const SizedBox(height: 20),
            Text(name, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
