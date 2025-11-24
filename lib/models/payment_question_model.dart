class PaymentQuestionModel {
  final int id;
  final String question;
  final List<String> options;
  final bool allowMultiple;
  final bool hasTextInput;
  final bool isTextArea;
  final int? maxLength;
  String? selectedAnswer;
  List<String>? selectedAnswers;
  String? textInput;

  PaymentQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    this.allowMultiple = false,
    this.hasTextInput = false,
    this.isTextArea = false,
    this.maxLength,
    this.selectedAnswer,
    this.selectedAnswers,
    this.textInput,
  });

  bool get isAnswered {
    if (hasTextInput || isTextArea) {
      return textInput != null && textInput!.isNotEmpty;
    }
    if (allowMultiple) {
      return selectedAnswers != null && selectedAnswers!.isNotEmpty;
    }
    return selectedAnswer != null && selectedAnswer!.isNotEmpty;
  }
}
