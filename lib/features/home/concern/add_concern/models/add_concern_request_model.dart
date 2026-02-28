class AddConcernRequestModel {
  final String category;
  final String subject;
  final String description;
  final String? attachmentPath;

  const AddConcernRequestModel({
    required this.category,
    required this.subject,
    required this.description,
    this.attachmentPath,
  });
}
