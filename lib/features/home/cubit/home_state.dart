import 'package:equatable/equatable.dart';

// Define the sealed states
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class UserInputs extends HomeState {
  final String storyLength;
  final String genre;
  final String input;
  final String storyteller; // NEW VARIABLE

  const UserInputs({
    this.storyLength = '',
    this.genre = 'horror',
    this.input = '',
    this.storyteller = 'main_american_female', // Default storyteller
  });

  @override
  List<Object?> get props => [storyLength, genre, input, storyteller];

  UserInputs copyWith(
      {String? storyLength,
      String? genre,
      String? input,
      String? storyteller}) {
    return UserInputs(
      storyLength: storyLength ?? this.storyLength,
      genre: genre ?? this.genre,
      input: input ?? this.input,
      storyteller: storyteller ?? this.storyteller, // Update storyteller
    );
  }
}

class StoryGenerationInProgress extends HomeState {}

class StoryGenerated extends HomeState {
  final String story;

  const StoryGenerated(this.story);

  @override
  List<Object?> get props => [story];
}

class StoryGenerationFailed extends HomeState {
  final String error;

  const StoryGenerationFailed(this.error);

  @override
  List<Object?> get props => [error];
}
