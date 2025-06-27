// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:service/models/service.dart';
// import 'package:service/pages/cleaning.dart';
// import 'package:service/pages/driver_page.dart';
// import 'package:service/pages/tailor_page.dart';
// import 'package:service/pages/electrician_page.dart';
//
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: selectedService >= 0
//           ? FloatingActionButton(
//               onPressed: () {
//                 Widget nextPage;
//
//                 switch (services[selectedService].name) {
//                   case 'Cleaning':
//                     nextPage = CleaningPage();
//                     break;
//                   case 'Driver':
//                     nextPage = const DriverPage();
//                     break;
//                   case 'Tailor':
//                     nextPage = const TailorPage();
//                     break;
//                   case 'Electrician':
//                     nextPage = const ElectricianPage();
//                     break;
//                   case 'CareTaker':
//                     nextPage = const CaretakerPage();
//                     break;
//                   case 'Cooker':
//                     nextPage = const CookPage();
//                     break;
//                   default:
//                     nextPage = CleaningPage();
//                 }
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => nextPage),
//                 );
//               },
//               backgroundColor: Colors.blue,
//               child: const Icon(Icons.arrow_forward_ios, size: 20),
//             )
//           : null,
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
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             FadeInUp(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20.0),
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
//                   crossAxisSpacing: 20.0,
//                   mainAxisSpacing: 20.0,
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
//             Image.asset(imagePath, height: 80),
//             const SizedBox(height: 20),
//             Text(name, style: const TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import '../auth/auth_service (1).dart';
//
// import '../auth/user_login_screen.dart';
// import '../pages/cleaning.dart';
//
// class UserDashboard extends StatelessWidget {
//   const UserDashboard({super.key});
//
//   void _logout(BuildContext context) async {
//     await AuthService().signout();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const UserLoginScreen()),
//     );
//   }
//
//   void _openChatbot(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (ctx) => ListView(
//         padding: const EdgeInsets.all(20),
//         children: faqAnswers.entries.map((entry) {
//           return Card(
//             elevation: 3,
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               title: Text(entry.key,
//                   style: const TextStyle(fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.pop(ctx);
//                 showDialog(
//                   context: context,
//                   builder: (_) => AlertDialog(
//                     title: const Text("🤖 ChatBot"),
//                     content: Text(entry.value),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text("Close"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User Dashboard"),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           IconButton(
//             onPressed: () => _logout(context),
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Center(
//         child: ElevatedButton.icon(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const CleaningPage()),
//             );
//           },
//           icon: const Icon(Icons.cleaning_services),
//           label: const Text("Book a Cleaner"),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.deepPurpleAccent,
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _openChatbot(context),
//         backgroundColor: Colors.deepPurpleAccent,
//         tooltip: "Ask Assistant",
//         child: const Icon(Icons.smart_toy),
//       ),
//     );
//   }
// }
//
// // ✅ Static FAQ data for chatbot
// Map<String, String> faqAnswers = {
//   "How to book a cleaner?":
//       "Go to 'Book a Cleaner', select a provider, choose date & time.",
//   "How to message a provider?": "On the cleaning page, tap the message icon.",
//   "How to cancel a booking?":
//       "Go to your bookings and click cancel on the booking you want to cancel.",
//   "How to rate provider?": "Open Booking Summary and select star rating.",
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
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => ListView(
        padding: const EdgeInsets.all(20),
        children: faqAnswers.entries.map((entry) {
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text(entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (selectedService >= 0)
            FloatingActionButton(
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
                    nextPage = const CookPage();
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
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _openChatbot(context),
            backgroundColor: Colors.deepPurple,
            heroTag: "chatbot",
            tooltip: "Need Help?",
            child: const Icon(Icons.smart_toy),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FadeInUp(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
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
            Image.asset(imagePath, height: 80),
            const SizedBox(height: 20),
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
  "How can I contact a provider?":
      "Tap on the message icon on the provider’s profile.",
  "How to cancel my booking?":
      "Open Booking Summary and select 'Cancel Booking'.",
  "Can I rate providers?":
      "Yes, after service you can give a star rating and feedback.",
};
