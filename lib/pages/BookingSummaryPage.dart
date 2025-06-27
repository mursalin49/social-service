// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'ChatScreen.dart';
//
// class BookingSummaryPage extends StatefulWidget {
//   final String bookingId;
//   final String userId;
//   final String providerId;
//   final String providerName;
//   final String date;
//   final String time;
//   final String status;
//   final String? cancelReason;
//
//   const BookingSummaryPage({
//     super.key,
//     required this.bookingId,
//     required this.userId,
//     required this.providerId,
//     required this.providerName,
//     required this.date,
//     required this.time,
//     required this.status,
//     this.cancelReason,
//   });
//
//   @override
//   State<BookingSummaryPage> createState() => _BookingSummaryPageState();
// }
//
// class _BookingSummaryPageState extends State<BookingSummaryPage> {
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
//
//   Future<void> _showCancelConfirmation() async {
//     final TextEditingController reasonController = TextEditingController();
//
//     bool? confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Cancel Booking?'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text('Please provide a reason for cancellation:'),
//             const SizedBox(height: 10),
//             TextField(
//               controller: reasonController,
//               decoration: const InputDecoration(
//                 hintText: 'Reason...',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//               child: const Text('No'),
//               onPressed: () => Navigator.pop(context, false)),
//           TextButton(
//               child: const Text('Yes'),
//               onPressed: () => Navigator.pop(context, true)),
//         ],
//       ),
//     );
//
//     if (confirm == true) {
//       if (reasonController.text.trim().isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please write a reason.')),
//         );
//         return;
//       }
//
//       await _dbRef.child('bookings').child(widget.bookingId).update({
//         'status': 'cancelled',
//         'cancelReason': reasonController.text.trim(),
//         'cancelledAt': DateTime.now().toIso8601String(),
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Booking cancelled successfully')),
//       );
//
//       setState(() {}); // To refresh status
//     }
//   }
//
//   void rateProvider(int rating) {
//     _dbRef.child('ratings').push().set({
//       'userId': widget.userId,
//       'providerId': widget.providerId,
//       'rating': rating,
//       'timestamp': DateTime.now().millisecondsSinceEpoch,
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Thanks for your feedback!')),
//     );
//   }
//
//   Future<void> generateInvoice() async {
//     final pdf = pw.Document();
//
//     pdf.addPage(
//       pw.Page(
//         build: (context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('🧾 Booking Invoice', style: pw.TextStyle(fontSize: 24)),
//             pw.SizedBox(height: 20),
//             pw.Text('Booking ID: ${widget.bookingId}'),
//             pw.Text('User ID: ${widget.userId}'),
//             pw.Text('Provider: ${widget.providerName}'),
//             pw.Text('Date: ${widget.date}'),
//             pw.Text('Time: ${widget.time}'),
//             pw.Text('Status: ${widget.status}'),
//             if (widget.status == 'cancelled')
//               pw.Text('Cancellation Reason: ${widget.cancelReason ?? 'N/A'}'),
//             pw.SizedBox(height: 20),
//             pw.Text('Thank you for using our service!',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//
//     await Printing.layoutPdf(onLayout: (format) async => pdf.save());
//   }
//
//   void _showHelpDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('📞 Help Center'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             ListTile(
//               leading: Icon(Icons.phone),
//               title: Text('Helpline'),
//               subtitle: Text('+880123456789'),
//             ),
//             ListTile(
//               leading: Icon(Icons.email),
//               title: Text('Email'),
//               subtitle: Text('support@yourapp.com'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             child: const Text('Close'),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isCancelled = widget.status == 'cancelled';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Booking Summary'),
//         backgroundColor: isCancelled ? Colors.redAccent : Colors.black12,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.help_outline),
//             tooltip: 'Help Center',
//             onPressed: _showHelpDialog,
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           elevation: 6,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: ListView(
//               children: [
//                 Text(widget.providerName,
//                     style: const TextStyle(
//                         fontSize: 22, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 buildInfoRow("Date", widget.date),
//                 buildInfoRow("Time", widget.time),
//                 buildInfoRow("Status", widget.status,
//                     color: isCancelled ? Colors.red : Colors.green),
//                 if (isCancelled && widget.cancelReason != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Text("❌ Reason: ${widget.cancelReason!}",
//                         style: const TextStyle(color: Colors.redAccent)),
//                   ),
//                 const Divider(height: 30),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ChatScreen(
//                           receiverId: widget.providerId,
//                           receiverName: widget.providerName,
//                         ),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.message),
//                   label: const Text('Message Provider'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey.shade300,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 if (!isCancelled)
//                   ElevatedButton.icon(
//                     onPressed: _showCancelConfirmation,
//                     icon: const Icon(Icons.cancel),
//                     label: const Text('Cancel Booking'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.redAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 const SizedBox(height: 30),
//                 const Text('Rate Provider:',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 Row(
//                   children: List.generate(5, (index) {
//                     return IconButton(
//                       icon: Icon(Icons.star_border, color: Colors.orange[400]),
//                       onPressed: () => rateProvider(index + 1),
//                     );
//                   }),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   onPressed: generateInvoice,
//                   icon: const Icon(Icons.picture_as_pdf),
//                   label: const Text("Download Invoice"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.grey.shade300,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildInfoRow(String title, String value, {Color? color}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text("$title: ",
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           Text(value,
//               style: TextStyle(fontSize: 16, color: color ?? Colors.black87)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'ChatScreen.dart';

class BookingSummaryPage extends StatefulWidget {
  final String bookingId;
  final String userId;
  final String providerId;
  final String providerName;
  final String date;
  final String time;
  final String status;
  final String? cancelReason;

  const BookingSummaryPage({
    super.key,
    required this.bookingId,
    required this.userId,
    required this.providerId,
    required this.providerName,
    required this.date,
    required this.time,
    required this.status,
    this.cancelReason,
  });

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryPageState();
}

class _BookingSummaryPageState extends State<BookingSummaryPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> _showCancelConfirmation() async {
    final TextEditingController reasonController = TextEditingController();

    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for cancellation:'),
            const SizedBox(height: 10),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Reason...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.pop(context, false)),
          TextButton(
              child: const Text('Yes'),
              onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );

    if (confirm == true) {
      if (reasonController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please write a reason.')),
        );
        return;
      }

      await _dbRef.child('bookings').child(widget.bookingId).update({
        'status': 'cancelled',
        'cancelReason': reasonController.text.trim(),
        'cancelledAt': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking cancelled successfully')),
      );

      setState(() {});
    }
  }

  void rateProvider(int rating) {
    _dbRef.child('ratings').push().set({
      'userId': widget.userId,
      'providerId': widget.providerId,
      'rating': rating,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thanks for your feedback!')),
    );
  }

  Future<void> generateInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('🧾 Booking Invoice', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Booking ID: ${widget.bookingId}'),
            pw.Text('User ID: ${widget.userId}'),
            pw.Text('Provider: ${widget.providerName}'),
            pw.Text('Date: ${widget.date}'),
            pw.Text('Time: ${widget.time}'),
            pw.Text('Status: ${widget.status}'),
            if (widget.status == 'cancelled')
              pw.Text('Cancellation Reason: ${widget.cancelReason ?? 'N/A'}'),
            pw.SizedBox(height: 20),
            pw.Text('Thank you for using our service!',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('📞 Help Center'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('Support Number'),
              subtitle: Text('+880 1234-567890'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('Support Email'),
              subtitle: Text('support@serviceapp.com'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCancelled = widget.status == 'cancelled';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
        backgroundColor: isCancelled ? Colors.redAccent : Colors.deepPurple,
        actions: [
          TextButton.icon(
            onPressed: _showHelpDialog,
            icon: const Icon(Icons.help_outline, color: Colors.white),
            label: const Text('Help Center',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text(widget.providerName,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                buildInfoRow("Date", widget.date),
                buildInfoRow("Time", widget.time),
                buildInfoRow("Status", widget.status,
                    color: isCancelled ? Colors.red : Colors.green),
                if (isCancelled && widget.cancelReason != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("❌ Reason: ${widget.cancelReason!}",
                        style: const TextStyle(color: Colors.redAccent)),
                  ),
                const Divider(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          receiverId: widget.providerId,
                          receiverName: widget.providerName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.message),
                  label: const Text('Message Provider'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 10),
                if (!isCancelled)
                  ElevatedButton.icon(
                    onPressed: _showCancelConfirmation,
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                const SizedBox(height: 30),
                const Text('Rate Provider:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(Icons.star_border, color: Colors.orange[400]),
                      onPressed: () => rateProvider(index + 1),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: generateInvoice,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("Download Invoice"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          receiverId: 'Io3HRqQlq0bv37R0DNl00MsVr4r2',
                          receiverName: 'Admin Support',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.support_agent),
                  label: const Text("Contact Admin"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$title: ",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value,
              style: TextStyle(fontSize: 16, color: color ?? Colors.black87)),
        ],
      ),
    );
  }
}
