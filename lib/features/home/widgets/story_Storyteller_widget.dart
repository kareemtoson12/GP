import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/styles/customs_color.dart';
import 'package:whispertales/core/styles/styles.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/home/cubit/home_state.dart';

class StorytellerWidget extends StatelessWidget {
  const StorytellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        final Map<String, String> storytellers = {
          "Marina": "main_american_female",
          "Habiba": "american_female_1",
          "Hager": "american_female_2",
          "Mariam": "american_female_3",
          "Hanna": "american_female_4",
          "Rana": "american_female_5",
          "Laila": "british_female",
          "Karim": "american_male_1",
          "Ali": "american_male_2",
          "Yasser": "american_male_3",
          "Mohamed": "american_male_4",
          "Saad": "british_male",
        };

        // Ensure selected storyteller exists in the map, else take the first one
        String? selectedStoryteller = (state is UserInputs &&
                storytellers.containsValue(state.storyteller))
            ? state.storyteller
            : storytellers.values.first; // Default to the first storyteller

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select a storyteller:',
                  style: AppTextStyles.font20GoogleFont),
              SizedBox(height: 10.h),
              DropdownButtonFormField<String>(
                style: AppTextStyles.font20GoogleFontEWhite,
                value: selectedStoryteller, // Ensure it's a valid value
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
                    cubit.updateInputs(
                        storyteller: newValue); // Pass storyteller
                  }
                },
                items:
                    storytellers.entries.map<DropdownMenuItem<String>>((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key,
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
