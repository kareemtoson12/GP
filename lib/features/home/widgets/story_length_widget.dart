import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/home/cubit/home_state.dart';

class StoryLengthSelection extends StatelessWidget {
  const StoryLengthSelection({super.key});

  // Define mapping from string to numeric value
  static const Map<String, int> lengthValues = {
    'Short': 100,
    'Medium': 200,
    'Long': 300,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        String? selectedLength = state is UserInputs ? state.storyLength : null;
        // Get the numeric value based on the selected length
        //  int currentValue = lengthValues[selectedLength] ?? 0;

        Widget storyLengthWidget(String length) {
          bool isSelected = length == selectedLength;
          return GestureDetector(
            onTap: () => cubit.updateInputs(storyLength: length),
            child: Container(
              margin: EdgeInsets.all(8.0.dg),
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: isSelected
                    ? CustomsColros.darkblue
                    : CustomsColros.lightPurple,
                border:
                    Border.all(color: CustomsColros.borderColor, width: 1.0),
              ),
              child: Center(
                child: Text(length,
                    style: AppTextStyles.font20GoogleFont
                        .copyWith(fontSize: 16.dg)),
              ),
            ),
          );
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(child: storyLengthWidget('Short')),
                Expanded(child: storyLengthWidget('Medium')),
                Expanded(child: storyLengthWidget('Long')),
              ],
            ),
          ],
        );
      },
    );
  }
}
