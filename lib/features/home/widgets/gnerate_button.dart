import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispertales/features/audio/view.dart';
import 'package:whispertales/features/home/cubit/home_cubit.dart';
import 'package:whispertales/features/home/cubit/home_state.dart';

class GenerateButton extends StatelessWidget {
  const GenerateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is StoryGenerationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
          context.read<HomeCubit>().resetState(); // Reset state after error
        }
        if (state is StoryGenerated) {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => AudioScreen(story: state.story),
            ),
          )
              .then((_) {
            // Reset the state so the home screen becomes responsive again.
            context.read<HomeCubit>().resetState();
          });
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return GestureDetector(
          onTap: () {
            cubit.generateStory();
          },
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue, // or CustomsColros.darkblue
            ),
            child: Center(
              child: state is StoryGenerationInProgress
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Generate',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
            ),
          ),
        );
      },
    );
  }
}
