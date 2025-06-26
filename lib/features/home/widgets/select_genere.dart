import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/home/cubit/home_state.dart';

class CategorySelection extends StatelessWidget {
  const CategorySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        String? selectedGenre = state is UserInputs ? state.genre : 'horror';

        final List<String> categories = [
          "superhero",
          "action",
          "drama",
          "thriller",
          "horror",
          "sci_fi"
        ];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select a Genre:', style: AppTextStyles.font20GoogleFont),
              SizedBox(height: 10.h),
              DropdownButtonFormField<String>(
                style: AppTextStyles.font20GoogleFontEWhite,
                value: selectedGenre,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomsColros.lightPurple)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomsColros.lightPurple)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  filled: true,
                  fillColor: CustomsColros.lightPurple,
                ),
                dropdownColor: CustomsColros.lightPurple,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    cubit.updateInputs(genre: newValue);
                  }
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
