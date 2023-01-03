/// id : 1
/// title : "Enable Developer Mode on Android"
/// description : "Enabling Developer Mode on Android 13 for access to developer settings"
/// postCreatedAt : "2023-01-02T21:11:45.280416"
/// instructions : "1. Open Settings, 2. Open About Phone, 3. Click Android Version, 4. Click Build Number 7 Times, 5. Navigate to Settings/System/Developer Options"
/// createdBy : "bjharan7@gmail.com"
/// category : "Technology"
/// likes : 5
/// dislikes : 2
/// tags : "Android, settings, developer mode"
/// difficulty : "Easy"
/// timeToComplete : "2 Minutes"
/// sponsored : false

class CommunityMadeInstructions {
  CommunityMadeInstructions({
      num? id, 
      String? title, 
      String? description, 
      String? postCreatedAt, 
      String? instructions, 
      String? createdBy, 
      String? category, 
      num? likes, 
      num? dislikes, 
      String? tags, 
      num? difficulty,
      String? timeToComplete, 
      bool? sponsored,}){
    _id = id;
    _title = title;
    _description = description;
    _postCreatedAt = postCreatedAt;
    _instructions = instructions;
    _createdBy = createdBy;
    _category = category;
    _likes = likes;
    _dislikes = dislikes;
    _tags = tags;
    _difficulty = difficulty;
    _timeToComplete = timeToComplete;
    _sponsored = sponsored;
}

  CommunityMadeInstructions.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _postCreatedAt = json['postCreatedAt'];
    _instructions = json['instructions'];
    _createdBy = json['createdBy'];
    _category = json['category'];
    _likes = json['likes'];
    _dislikes = json['dislikes'];
    _tags = json['tags'];
    _difficulty = json['difficulty'];
    _timeToComplete = json['timeToComplete'];
    _sponsored = json['sponsored'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _postCreatedAt;
  String? _instructions;
  String? _createdBy;
  String? _category;
  num? _likes;
  num? _dislikes;
  String? _tags;
  num? _difficulty;
  String? _timeToComplete;
  bool? _sponsored;
CommunityMadeInstructions copyWith({  num? id,
  String? title,
  String? description,
  String? postCreatedAt,
  String? instructions,
  String? createdBy,
  String? category,
  num? likes,
  num? dislikes,
  String? tags,
  num? difficulty,
  String? timeToComplete,
  bool? sponsored,
}) => CommunityMadeInstructions(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  postCreatedAt: postCreatedAt ?? _postCreatedAt,
  instructions: instructions ?? _instructions,
  createdBy: createdBy ?? _createdBy,
  category: category ?? _category,
  likes: likes ?? _likes,
  dislikes: dislikes ?? _dislikes,
  tags: tags ?? _tags,
  difficulty: difficulty ?? _difficulty,
  timeToComplete: timeToComplete ?? _timeToComplete,
  sponsored: sponsored ?? _sponsored,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get postCreatedAt => _postCreatedAt;
  String? get instructions => _instructions;
  String? get createdBy => _createdBy;
  String? get category => _category;
  num? get likes => _likes;
  num? get dislikes => _dislikes;
  String? get tags => _tags;
  num? get difficulty => _difficulty;
  String? get timeToComplete => _timeToComplete;
  bool? get sponsored => _sponsored;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['postCreatedAt'] = _postCreatedAt;
    map['instructions'] = _instructions;
    map['createdBy'] = _createdBy;
    map['category'] = _category;
    map['likes'] = _likes;
    map['dislikes'] = _dislikes;
    map['tags'] = _tags;
    map['difficulty'] = _difficulty;
    map['timeToComplete'] = _timeToComplete;
    map['sponsored'] = _sponsored;
    return map;
  }

}