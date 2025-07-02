// // import 'package:flutter/material.dart';
// // import 'package:animate_do/animate_do.dart';
// // import 'package:service/models/service.dart';
// // import 'package:service/pages/cleaning.dart';
// // import 'package:service/pages/driver_page.dart';
// // import 'package:service/pages/tailor_page.dart';
// // import 'package:service/pages/electrician_page.dart';
// // import '../pages/caretaker_page.dart';
// // import '../pages/cook_page.dart';
// //
// // class UserDashboard extends StatefulWidget {
// //   const UserDashboard({Key? key}) : super(key: key);
// //
// //   @override
// //   _UserDashboardState createState() => _UserDashboardState();
// // }
// //
// // class _UserDashboardState extends State<UserDashboard> {
// //   List<Service> services = [
// //     Service('Cleaning', 'assets/images/clean.png'),
// //     Service('Electrician', 'assets/images/electri.png'),
// //     Service('Tailor', 'assets/images/tailor.png'),
// //     Service('CareTaker', 'assets/images/care.jpg'),
// //     Service('Driver', 'assets/images/driver.png'),
// //     Service('Cooker', 'assets/images/cooker.png'),
// //   ];
// //
// //   int selectedService = -1;
// //
// //   void _openChatbot(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.white,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (ctx) => FractionallySizedBox(
// //         heightFactor: 0.8,
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const SizedBox(height: 16),
// //             // 👇 Header with icon and text
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: const [
// //                 Icon(Icons.chat_bubble_outline, color: Colors.deepPurple),
// //                 SizedBox(width: 8),
// //                 Text(
// //                   "ChatBot Help Center",
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.deepPurple,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 30),
// //             const Divider(thickness: 1),
// //             Expanded(
// //               child: ListView(
// //                 padding: const EdgeInsets.all(20),
// //                 children: faqAnswers.entries.map((entry) {
// //                   return Card(
// //                     elevation: 2,
// //                     child: ListTile(
// //                       title: Text(
// //                         entry.key,
// //                         style: const TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                       onTap: () {
// //                         Navigator.pop(ctx);
// //                         showDialog(
// //                           context: context,
// //                           builder: (_) => AlertDialog(
// //                             title: const Text("🤖 ChatBot"),
// //                             content: Text(entry.value),
// //                             actions: [
// //                               TextButton(
// //                                 onPressed: () => Navigator.pop(context),
// //                                 child: const Text("Close"),
// //                               ),
// //                             ],
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       floatingActionButton: Stack(
// //         children: [
// //           if (selectedService >= 0)
// //             Positioned(
// //               bottom: 90,
// //               right: 20,
// //               child: FloatingActionButton(
// //                 onPressed: () {
// //                   Widget nextPage;
// //                   switch (services[selectedService].name) {
// //                     case 'Cleaning':
// //                       nextPage = CleaningPage();
// //                       break;
// //                     case 'Driver':
// //                       nextPage = const DriverPage();
// //                       break;
// //                     case 'Tailor':
// //                       nextPage = const TailorPage();
// //                       break;
// //                     case 'Electrician':
// //                       nextPage = const ElectricianPage();
// //                       break;
// //                     case 'CareTaker':
// //                       nextPage = const CaretakerPage();
// //                       break;
// //                     case 'Cooker':
// //                       nextPage = const CookerPage();
// //                       break;
// //                     default:
// //                       nextPage = CleaningPage();
// //                   }
// //
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => nextPage),
// //                   );
// //                 },
// //                 backgroundColor: Colors.blue,
// //                 heroTag: "go",
// //                 child: const Icon(Icons.arrow_forward_ios, size: 20),
// //               ),
// //             ),
// //           Positioned(
// //             bottom: 20,
// //             right: 20,
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 FloatingActionButton(
// //                   onPressed: () => _openChatbot(context),
// //                   backgroundColor: Colors.black12,
// //                   heroTag: "chatbot",
// //                   tooltip: "Need Help?",
// //                   child: const Icon(Icons.smart_toy, color: Colors.deepPurple),
// //                 ),
// //                 const SizedBox(height: 6),
// //                 const Text(
// //                   "ChatBot",
// //                   style: TextStyle(
// //                     color: Colors.deepPurple,
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         title: const Text(
// //           'User Dashboard',
// //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(15.0),
// //         child: Column(
// //           children: [
// //             FadeInUp(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10.0),
// //                 child: Text(
// //                   'Select a service you want to hire',
// //                   style: TextStyle(
// //                     fontSize: 22,
// //                     color: Colors.grey.shade900,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Expanded(
// //               child: GridView.builder(
// //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 2,
// //                   childAspectRatio: 1.0,
// //                   crossAxisSpacing: 10.0,
// //                   mainAxisSpacing: 10.0,
// //                 ),
// //                 physics: const BouncingScrollPhysics(),
// //                 itemCount: services.length,
// //                 itemBuilder: (context, index) {
// //                   return FadeInUp(
// //                     delay: Duration(milliseconds: 500 * index),
// //                     child: serviceContainer(
// //                       services[index].imageURL,
// //                       services[index].name,
// //                       index,
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget serviceContainer(String imagePath, String name, int index) {
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() {
// //           selectedService = (selectedService == index) ? -1 : index;
// //         });
// //       },
// //       child: AnimatedContainer(
// //         duration: const Duration(milliseconds: 300),
// //         padding: const EdgeInsets.all(10.0),
// //         decoration: BoxDecoration(
// //           color: selectedService == index
// //               ? Colors.blue.shade50
// //               : Colors.grey.shade100,
// //           border: Border.all(
// //             color: selectedService == index ? Colors.blue : Colors.transparent,
// //             width: 2.0,
// //           ),
// //           borderRadius: BorderRadius.circular(20.0),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Image.asset(imagePath, height: 70),
// //             const SizedBox(height: 15),
// //             Text(name, style: const TextStyle(fontSize: 20)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // ✅ Static chatbot FAQ data
// // Map<String, String> faqAnswers = {
// //   "How to hire a cleaner?":
// //       "Go to the Cleaning section, select a provider, then book date & time.",
// //   "How to hire an electrician?":
// //       "Go to the Electrician section, select a provider, then book date & time.",
// //   "How to hire a tailor?":
// //       "Go to the Tailor section, select a provider, then book date & time.",
// //   "How to hire a driver?":
// //       "Go to the Driver section, select a provider, then book date & time.",
// //   "How to hire a caretaker?":
// //       "Go to the CareTaker section, select a provider, then book date & time.",
// //   "How to hire a cook?":
// //       "Go to the Cooker section, select a provider, then book date & time.",
// //   "How can I contact a provider?":
// //       "Tap on the message icon on the provider’s profile.",
// //   "How to cancel my booking?":
// //       "Open Booking Summary and select 'Cancel Booking'.",
// //   "Can I rate providers?":
// //       "Yes, after service you can give a star rating and feedback.",
// // };
// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:service/models/service.dart';
// import 'package:service/pages/cleaning.dart';
// import 'package:service/pages/driver_page.dart';
// import 'package:service/pages/tailor_page.dart';
// import 'package:service/pages/electrician_page.dart';
// import '../pages/caretaker_page.dart';
// import '../pages/cook_page.dart';
//
// class UserDashboard extends StatefulWidget {
//   const UserDashboard({Key? key}) : super(key: key);
//
//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }
//
// class _UserDashboardState extends State<UserDashboard> {
//   List<Service> services = [
//     Service('Cleaning', 'assets/images/clean.png'),
//     Service('Electrician', 'assets/images/electri.png'),
//     Service('Tailor', 'assets/images/tailor.png'),
//     Service('CareTaker', 'assets/images/care.jpg'),
//     Service('Driver', 'assets/images/driver.png'),
//     Service('Cooker', 'assets/images/cooker.png'),
//   ];
//
//   int selectedService = -1;
//
//   void _openChatbot(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (ctx) => FractionallySizedBox(
//         heightFactor: 0.8,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.chat_bubble_outline, color: Colors.deepPurple),
//                 SizedBox(width: 8),
//                 Text(
//                   "ChatBot Help Center",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             const Divider(thickness: 1),
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.all(20),
//                 children: faqAnswers.entries.map((entry) {
//                   return Card(
//                     elevation: 2,
//                     child: ListTile(
//                       title: Text(
//                         entry.key,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       onTap: () {
//                         Navigator.pop(ctx);
//                         showDialog(
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: const Text("🤖 ChatBot"),
//                             content: Text(entry.value),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text("Close"),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: Stack(
//         children: [
//           if (selectedService >= 0)
//             Positioned(
//               bottom: 90,
//               right: 20,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   Widget nextPage;
//                   switch (services[selectedService].name) {
//                     case 'Cleaning':
//                       nextPage = CleaningPage();
//                       break;
//                     case 'Driver':
//                       nextPage = const DriverPage();
//                       break;
//                     case 'Tailor':
//                       nextPage = const TailorPage();
//                       break;
//                     case 'Electrician':
//                       nextPage = const ElectricianPage();
//                       break;
//                     case 'CareTaker':
//                       nextPage = const CaretakerPage();
//                       break;
//                     case 'Cooker':
//                       nextPage = const CookerPage();
//                       break;
//                     default:
//                       nextPage = CleaningPage();
//                   }
//
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => nextPage),
//                   );
//                 },
//                 backgroundColor: Colors.blue,
//                 heroTag: "go",
//                 child: const Icon(Icons.arrow_forward_ios, size: 20),
//               ),
//             ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: () => _openChatbot(context),
//                     backgroundColor: Colors.black12,
//                     heroTag: "chatbot",
//                     tooltip: "Need Help?",
//                     child:
//                         const Icon(Icons.smart_toy, color: Colors.deepPurple),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "ChatBot",
//                     style: TextStyle(
//                       color: Colors.deepPurple,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'User Dashboard',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             FadeInUp(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Text(
//                   'Select a service you want to hire',
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.grey.shade900,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1.0,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 10.0,
//                 ),
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: services.length,
//                 itemBuilder: (context, index) {
//                   return FadeInUp(
//                     delay: Duration(milliseconds: 500 * index),
//                     child: serviceContainer(
//                       services[index].imageURL,
//                       services[index].name,
//                       index,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
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
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.all(10.0),
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
//             Image.asset(imagePath, height: 70),
//             const SizedBox(height: 15),
//             Text(name, style: const TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ✅ Static chatbot FAQ data
// Map<String, String> faqAnswers = {
//   "How to hire a cleaner?":
//       "Go to the Cleaning section, select a provider, then book date & time.",
//   "How to hire an electrician?":
//       "Go to the Electrician section, select a provider, then book date & time.",
//   "How to hire a tailor?":
//       "Go to the Tailor section, select a provider, then book date & time.",
//   "How to hire a driver?":
//       "Go to the Driver section, select a provider, then book date & time.",
//   "How to hire a caretaker?":
//       "Go to the CareTaker section, select a provider, then book date & time.",
//   "How to hire a cook?":
//       "Go to the Cooker section, select a provider, then book date & time.",
//   "How can I contact a provider?":
//       "Tap on the message icon on the provider’s profile.",
//   "How to cancel my booking?":
//       "Open Booking Summary and select 'Cancel Booking'.",
//   "Can I rate providers?":
//       "Yes, after service you can give a star rating and feedback.",
// };
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:service/models/service.dart';
import 'package:service/pages/cleaning.dart';
import 'package:service/pages/driver_page.dart';
import 'package:service/pages/tailor_page.dart';
import 'package:service/pages/electrician_page.dart';
import '../pages/caretaker_page.dart';
import '../pages/cook_page.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<Service> services = [
    Service('Cleaning', 'assets/images/clean.png'),
    Service('Electrician', 'assets/images/electri.png'),
    Service('Tailor', 'assets/images/tailor.png'),
    Service('CareTaker', 'assets/images/care.jpg'),
    Service('Driver', 'assets/images/driver.png'),
    Service('Cooker', 'assets/images/cooker.png'),
  ];

  int selectedService = -1;

  void _openChatbot(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.chat_bubble_outline, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "ChatBot Help Center",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: faqAnswers.entries.map((entry) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("🤖 ChatBot"),
                            content: Text(entry.value),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Stack(
        children: [
          if (selectedService >= 0)
            Positioned(
              bottom: 90,
              right: 20,
              child: FloatingActionButton(
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
                      nextPage = CleaningPage();
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => nextPage),
                  );
                },
                backgroundColor: Colors.blue,
                heroTag: "go",
                child: const Icon(Icons.arrow_forward_ios, size: 20),
              ),
            ),
          Positioned(
            bottom: 2, // <-- এখানে ভ্যালু কমিয়ে নিচে নিয়ে আসলাম
            left: 260,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () => _openChatbot(context),
                  backgroundColor: Colors.black12,
                  heroTag: "chatbot",
                  tooltip: "Need Help?",
                  child: const Icon(Icons.smart_toy, color: Colors.deepPurple),
                ),
                const SizedBox(height: 2),
                const Text(
                  "ChatBot",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'User Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            FadeInUp(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Select a service you want to hire',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                physics: const BouncingScrollPhysics(),
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
            Image.asset(imagePath, height: 70),
            const SizedBox(height: 15),
            Text(name, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

// ✅ Static chatbot FAQ data
Map<String, String> faqAnswers = {
  "How to hire a cleaner?":
      "Go to the Cleaning section, select a provider, then book date & time.",
  "How to hire an electrician?":
      "Go to the Electrician section, select a provider, then book date & time.",
  "How to hire a tailor?":
      "Go to the Tailor section, select a provider, then book date & time.",
  "How to hire a driver?":
      "Go to the Driver section, select a provider, then book date & time.",
  "How to hire a caretaker?":
      "Go to the CareTaker section, select a provider, then book date & time.",
  "How to hire a cook?":
      "Go to the Cooker section, select a provider, then book date & time.",
  "How can I contact a provider?":
      "Tap on the message icon on the provider’s profile.",
  "How to cancel my booking?":
      "Open Booking Summary and select 'Cancel Booking'.",
  "Can I rate providers?":
      "Yes, after service you can give a star rating and feedback.",
};
