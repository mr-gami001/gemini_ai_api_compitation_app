// import 'package:flutter/material.dart';

// import '../../utils/text_style.dart';
// import '../app_landing/dependecy_inject.dart';
// import '../fitness_activity/fitness_activity.dart';

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({super.key});

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.purpleAccent,
//       width: MediaQuery.of(context).size.width * 0.65,
//       child: SafeArea(
//           child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           CircleAvatar(
//             radius: MediaQuery.of(context).size.width * 0.2,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ListTile(
//             onTap: () async {
//               await Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => FitnessActivityScreen(),
//                 ),
//               );
//             },
//             leading: const SizedBox(
//               width: 0,
//             ),
//             titleAlignment: ListTileTitleAlignment.center,
//             title: Text(
//               "Show Activity!",
//               style: getIt<AppTextStyle>().mukta25pxSemoBold,
//             ),
//             contentPadding: EdgeInsets.zero,
//             minVerticalPadding: 0,
//             trailing: const Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: Icon(Icons.arrow_forward_ios_outlined),
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
