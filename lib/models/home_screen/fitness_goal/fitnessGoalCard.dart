import 'package:fitness_coach_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/text_style.dart';
import '../../app_landing/dependecy_inject.dart';

class Fitnessgoalcard extends StatefulWidget {
  String title;
  String desc;
  VoidCallback onTap;
  String? iconText;
  bool? isSelected;
  Fitnessgoalcard(
      {super.key,
      required this.title,
      required this.desc,
      required this.onTap,
      this.iconText,
      this.isSelected});

  @override
  State<Fitnessgoalcard> createState() => _FitnessgoalcardState();
}

class _FitnessgoalcardState extends State<Fitnessgoalcard> {
  List checkList = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap??(){
        if(!checkList.contains(widget.title)){
          checkList.add(widget.title);
        }else{
          checkList.remove(widget.title);
        }
        setState(() {

        });
      },
      child: Card(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (widget.iconText != null)
              Container(
                width: (MediaQuery.of(context).size.width - 40) * 0.4,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(widget.iconText!),
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high)),
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
                    widget.title,
                    textAlign: TextAlign.start,
                    style: getIt<AppTextStyle>().mukta15pxbold,
                  ),
                  Text(
                    widget.desc,
                    textAlign: TextAlign.start,
                    style: getIt<AppTextStyle>().mukta13pxnormal,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 20,
              child: Checkbox(
                value: widget.isSelected,
                onChanged: (bool? value) {
                  widget.onTap.call();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
