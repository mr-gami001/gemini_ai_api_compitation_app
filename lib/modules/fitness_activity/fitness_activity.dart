// import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// import '../../utils/text_style.dart';
// import '../app_landing/dependecy_inject.dart';

// class FitnessActivityScreen extends StatefulWidget {
//   const FitnessActivityScreen({super.key});

//   @override
//   State<FitnessActivityScreen> createState() => _FitnessActivityScreenState();
// }

// class _FitnessActivityScreenState extends State<FitnessActivityScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   @override
//   void initState() {
//     controller = AnimationController(
//       /// [AnimationController]s can be created with `vsync: this` because of
//       /// [TickerProviderStateMixin].
//       vsync: this,
//       duration: const Duration(seconds: 5),
//     )..addListener(() {});
//     controller.repeat(reverse: true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purpleAccent,
//         centerTitle: true,
//         title: Text(
//           "Fitness Activity",
//           style: getIt<AppTextStyle>().mukta25pxSemoBold,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             // AnimatedBuilder(
//             //   animation: controller,
//             //   builder: (context, value) {
//             //     return Transform.rotate(
//             //       angle: controller.value * 2.0 * math.pi,
//             //       child: CircularProgressIndicator(
//             //         value: controller.value,
//             //         semanticsValue: '10',
//             //       ),
//             //     );
//             //   },
//             // ),
//             CircularPercentIndicator(
//               radius: 60.0,
//               lineWidth: 5.0,
//               percent: 0.5,
//               center: new Text("100%"),
//               progressColor: Colors.green,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
