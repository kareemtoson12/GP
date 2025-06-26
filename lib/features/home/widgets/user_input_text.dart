import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/home/cubit/home_state.dart';

class UserInputText extends StatelessWidget {
  const UserInputText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          //  String? userInput = state is UserInputs ? state.input : '';

          return TextField(
            style: AppTextStyles.font20GoogleFontEWhite,
            decoration: InputDecoration(
              // When the TextField is not focused
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              // When the TextField is focused
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              // Optional: a default border if you want to show the outline when disabled
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 120.0.h),
              hintText: '   Describe your topic...',
              hintStyle: AppTextStyles.font20GoogleFontEWhite.copyWith(
                color: Colors.grey,
              ),
            ),
            onChanged: (text) => cubit.updateInputs(input: text),
          );
        },
      ),
    );
  }
}
