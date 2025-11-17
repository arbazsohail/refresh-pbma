class EarnStepModel {
  final String stepNumber;
  final String title;
  final String description;

  EarnStepModel({
    required this.stepNumber,
    required this.title,
    required this.description,
  });

  factory EarnStepModel.fromJson(Map<String, dynamic> json) {
    return EarnStepModel(
      stepNumber: json['stepNumber'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
    };
  }
}

class EarnOptionModel {
  final String optionTitle;
  final List<EarnStepModel> steps;

  EarnOptionModel({
    required this.optionTitle,
    required this.steps,
  });

  factory EarnOptionModel.fromJson(Map<String, dynamic> json) {
    return EarnOptionModel(
      optionTitle: json['optionTitle'] ?? '',
      steps: (json['steps'] as List<dynamic>?)
              ?.map((step) => EarnStepModel.fromJson(step))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'optionTitle': optionTitle,
      'steps': steps.map((step) => step.toJson()).toList(),
    };
  }
}
