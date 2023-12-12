class Todo{
  int? id;
  late String title;
  late String description;
  bool? isDone;

  Todo({this.id ,required this.title, required this.description, this.isDone = false});

  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['is_done']
    );
  }

  @override
  String toString() {
    return "Todo(id: $id, title: $title, description: $description, is_done: $isDone)";
  }
}