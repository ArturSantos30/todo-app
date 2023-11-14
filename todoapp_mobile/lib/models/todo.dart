class Todo{
  int? id;
  late String title;
  late String description;

  Todo({this.id ,required this.title, required this.description});

  Todo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  @override
  String toString() {
    return "Todo(id: $id, title: $title, description: $description)";
  }
}