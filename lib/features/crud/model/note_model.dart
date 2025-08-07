class Note {
  final String id;
  final String title;
  final String description;

  Note({required this.id, required this.title, required this.description});

  factory Note.fromMap(Map<String, dynamic> map, String docId) {
    return Note(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
