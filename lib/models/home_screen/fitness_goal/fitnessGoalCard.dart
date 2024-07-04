import 'package:fitness_coach_app/models/home_screen/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';
import 'fitness_goal_dm.dart';

// ignore: must_be_immutable
class Fitnessgoalcard extends StatefulWidget {
  FitnessGoalDm? fitnessGoalDm;
  VoidCallback onTap;
  int? index;

  bool? isSelected;
  Fitnessgoalcard(
      {super.key,
      required this.fitnessGoalDm,
      required this.onTap,
      this.isSelected,
      this.index});

  @override
  State<Fitnessgoalcard> createState() => _FitnessgoalcardState();
}

class _FitnessgoalcardState extends State<Fitnessgoalcard> {
  List checkList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (widget.fitnessGoalDm?.iconText != null)
                  Flexible(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.fitnessGoalDm?.iconText ?? '',
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.fitnessGoalDm?.title ?? '',
                        textAlign: TextAlign.start,
                        style: getIt<AppTextStyle>().mukta15pxbold,
                      ),
                      Text(
                        widget.fitnessGoalDm?.desc ?? '',
                        textAlign: TextAlign.start,
                        style: getIt<AppTextStyle>().mukta13pxnormal,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 20,
                  child: Radio(
                    value: widget.isSelected,
                    onChanged: (value) {
                      widget.onTap.call();
                    },
                    groupValue: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            if ((widget.isSelected ?? false) && widget.index != 0)
              const SizedBox(
                height: 10,
              ),
            if (widget.isSelected ?? false)
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (int index = 0;
                      index < (widget.fitnessGoalDm?.keyPoints?.length ?? 0);
                      index++)
                    keyProp(widget.fitnessGoalDm?.keyPoints?[index])
                ],
              ),
            if ((widget.isSelected ?? false) && widget.index != 0)
              const SizedBox(
                height: 10,
              ),
          ],
        ),
      ),
    );
  }

  Widget keyProp(KeyPoint? keyPoint) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10),
        ),
        elevation: WidgetStateProperty.resolveWith<double>((state) => 0),
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (state) => const BorderSide(
            color: Colors.black38,
            width: 0,
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (state) {
            if (state.contains(WidgetState.pressed) ||
                (keyPoint?.isSelected ?? false)) {
              return Colors.purpleAccent;
            }
            return Colors.white;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (state) {
            if (state.contains(WidgetState.pressed) ||
                (keyPoint?.isSelected ?? false)) {
              return Colors.white;
            }
            return Colors.black;
          },
        ),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (state) {
            if (state.contains(WidgetState.pressed) ||
                (keyPoint?.isSelected ?? false)) {
              return getIt<AppTextStyle>().mukta10pxnormalWhite;
            }
            return getIt<AppTextStyle>().mukta10pxnormalBlack;
          },
        ),
      ),
      onPressed: () {
        int? itemIndex = widget.fitnessGoalDm?.keyPoints?.indexOf(keyPoint!);
        if (itemIndex != null) {
          KeyPoint tempItem = widget.fitnessGoalDm!.keyPoints![itemIndex];
          tempItem.isSelected = !(tempItem.isSelected ?? false);
          widget.fitnessGoalDm?.keyPoints?[itemIndex] = tempItem;
        }
        BlocProvider.of<HomeBloc>(context)
            .add(SelectFitnessGoalEvent(widget.fitnessGoalDm!));
      },
      child: Text(
        keyPoint?.title ?? '',
      ),
    );
  }
}
