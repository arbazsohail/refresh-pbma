class FAQModel {
  final String id;
  final String question;
  final String answer;
  bool isExpanded;

  FAQModel({
    required this.id,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      isExpanded: json['isExpanded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'isExpanded': isExpanded,
    };
  }
}
