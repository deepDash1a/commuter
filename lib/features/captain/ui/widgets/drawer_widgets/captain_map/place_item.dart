import 'package:commuter/core/shared/widgets/texts.dart';
import 'package:commuter/core/theme/colors/colors.dart';
import 'package:commuter/features/captain/data/captain_shift/places_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceItem extends StatelessWidget {
  final PlacesSuggestion suggestion;

  const PlaceItem({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.mainAppColor.withOpacity(0.5),
                child: const Icon(
                  Icons.place_outlined,
                  color: ColorsManager.white,
                ),
              ),
              const SizedBox(
                width: 10.00,
              ),
              Expanded(
                child: BoldText16dark(
                  text: suggestion.name,
                  color: ColorsManager.mainAppColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.00.h),
          BoldText16dark(
            text: suggestion.description,
            color: ColorsManager.mainAppColor,
          ),
        ],
      ),
    );
  }
}
