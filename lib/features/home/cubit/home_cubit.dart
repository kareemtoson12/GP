import 'package:bloc/bloc.dart';
import 'package:whispertales/features/home/cubit/home_state.dart';
import 'package:whispertales/features/home/data/models/generate_story_request.dart';
import 'package:whispertales/features/home/data/repo/generate_text_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final GenerateTextRepo generateTextRepo;

  HomeCubit({required this.generateTextRepo}) : super(UserInputs());

  // Update inputs only when state is UserInputs
  void updateInputs(
      {String? storyLength,
      String? genre,
      String? input,
      String? storyteller}) {
    if (state is UserInputs) {
      final currentState = state as UserInputs;
      emit(currentState.copyWith(
        storyLength: storyLength,
        genre: genre,
        input: input,
        storyteller: storyteller, // NEW PARAMETER
      ));
    }
  }

  Future<void> generateStory() async {
    if (state is UserInputs) {
      final currentState = state as UserInputs;
      if (currentState.input.isEmpty) {
        emit(const StoryGenerationFailed("Please enter a story topic!"));
        await Future.delayed(
            const Duration(seconds: 1)); // Short delay to show error
        resetState(); // Reset to UserInputs to allow another try
        return;
      }
      emit(StoryGenerationInProgress());

      final requestModel = RequestGnerateModel(
        genre: currentState.genre,
        prompt: currentState.input,
        targetLength: int.tryParse(currentState.storyLength) ?? 100,
        maxLength: 500,
      );

      final apiResult = await generateTextRepo.generateText(requestModel);

      apiResult.when(
        success: (response) {
          emit(StoryGenerated(response.generatedText));
        },
        failure: (error) {
          emit(const StoryGenerationFailed(
              "Failed to generate story! try again"));
        },
      );
    }
  }

  // Reset the state back to UserInputs
  void resetState() {
    emit(const UserInputs());
  }
}
