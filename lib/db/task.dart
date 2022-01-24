class Task {
  int? id;
  String? title;
  String? description;
  String? date;
  int? color;

  Task({
    this.id,
    this.title,
    this.description,
    this.date,
    this.color,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    color = json['color'];
  }

  // Task.toJson();

  // get note => null;

  Map<String, dynamic> toJson() {
    // print("calll json");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['color'] = this.color;
    print("calll json");
    return data;
  }
}
