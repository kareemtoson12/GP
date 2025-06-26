import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whispertales/core/styles/customs_color.dart';

import 'package:whispertales/core/styles/styles.dart';

import 'package:whispertales/features/home/widgets/gnerate_button.dart';
import 'package:whispertales/features/home/widgets/select_genere.dart';
import 'package:whispertales/features/home/widgets/story_Storyteller_widget.dart';

import 'package:whispertales/features/home/widgets/story_length_widget.dart';
import 'package:whispertales/features/home/widgets/user_input_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.primaryColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(5.dg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WhisperTales',
                    style: AppTextStyles.font20SeconColor,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              //generation length
              Text('How long should the story be?',
                  style:
                      AppTextStyles.font20GoogleFont.copyWith(fontSize: 25.dg)),
              const StoryLengthSelection(),
              SizedBox(
                height: 10.h,
              ),
              const CategorySelection(),
              SizedBox(
                height: 5.h,
              ),
              const StorytellerWidget(),
              // user input
              UserInputText(),

              //select genre

              SizedBox(
                height: 10.h,
              ),
              const Align(
                child: GenerateButton(),
              )
            ],
          ),
        ),
      )),
    );
  }
}
