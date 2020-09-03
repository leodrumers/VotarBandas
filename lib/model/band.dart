class Band {
  String id;
  String name;
  int votes;

  Band({this.id, this.name, this.votes});

  factory Band.from(Map<String, dynamic> obj) {
    return Band(
      id: obj['id'] as String,
      name: obj['name'] as String,
      votes: obj['votes'] as int,
    );
  }
}
