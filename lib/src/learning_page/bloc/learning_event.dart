import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class LearningEvent extends Equatable {
  const LearningEvent();

  @override
  List<Object> get props => [];
}

class StartLearning extends LearningEvent {}

class RevealAnswer extends LearningEvent {}

class NextCard extends LearningEvent {}

class LearningErrorEvent extends LearningEvent {}
