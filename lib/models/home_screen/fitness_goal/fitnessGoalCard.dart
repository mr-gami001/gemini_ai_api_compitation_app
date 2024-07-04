import 'package:flutter/material.dart';

import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';
import 'fitness_goal_dm.dart';

class Fitnessgoalcard extends StatefulWidget {
  FitnessGoalDm? fitnessGoalDm;
  VoidCallback onTap;

  bool? isSelected;
  Fitnessgoalcard(
      {super.key,
      required this.fitnessGoalDm,
      required this.onTap,
      this.isSelected});

  @override
  State<Fitnessgoalcard> createState() => _FitnessgoalcardState();
}

class _FitnessgoalcardState extends State<Fitnessgoalcard> {
  List checkList = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          ],
        ),
      ),
    );
  }

  Widget keyProp(KeyPoint? keyPoint) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: Colors.transparent,
        elevation: 0,
        side: const BorderSide(
          color: Colors.black38,
          width: 0,
        ),
      ),
      onPressed: () {},
      child: Text(
        keyPoint?.title ?? '',
        style: getIt<AppTextStyle>().mukta10pxnormal,
      ),
    );
  }
}
