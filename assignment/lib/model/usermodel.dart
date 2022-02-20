class usermodel {
  String? uid;
  String? email;
  String? name;
  String? enrollment;
  String? branch;
  String? batch;

  usermodel(
      {this.uid,
      this.email,
      this.name,
      this.enrollment,
      this.batch,
      this.branch});

  //receive data from server
  factory usermodel.fromMap(Map) {
    return usermodel(
        uid: Map('uid'),
        email: Map('email'),
        name: Map('name'),
        enrollment: Map('11111111'),
        branch: Map('cse'),
        batch: Map('o1'));
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'enrollment': enrollment,
      'branch': branch,
      'batch': batch
    };
  }
}
