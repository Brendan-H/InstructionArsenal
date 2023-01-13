/// content : [{"id":12,"title":"2 How to change the tire on a car","description":"This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry","postCreatedAt":"2023-01-03T16:54:30.756846","instructions":"Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on. Step 2: Locate the jack and the lug wrench. Step 3: Remove the lug nuts from the tire. Step 4: Place the jack under the car and raise it until the tire is off the ground. Step 5: Remove the tire and replace it with the spare. Step 6: Replace the lug nuts and tighten them. Step 7: Lower the car and remove the jack. Step 8: Replace the lug wrench and jack in their original locations. Step 9: Turn on the car and drive away. Step 10: Go to a tire shop to get the flat tire fixed.","createdBy":"bjharan7@gmail.com","category":"Automotive","likes":155,"dislikes":11,"tags":"cars, tire, automotive, wheels, repair","difficulty":3,"timeToComplete":"30 Minutes","sponsored":true},{"id":16,"title":"How to do something","description":"This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry","postCreatedAt":"2023-01-03T16:58:49.802276","instructions":"Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on. Step 2: Locate the jack and the lug wrench. Step 3: Remove the lug nuts from the tire. Step 4: Place the jack under the car and raise it until the tire is off the ground. Step 5: Remove the tire and replace it with the spare. Step 6: Replace the lug nuts and tighten them. Step 7: Lower the car and remove the jack. Step 8: Replace the lug wrench and jack in their original locations. Step 9: Turn on the car and drive away. Step 10: Go to a tire shop to get the flat tire fixed.","createdBy":"bjharan7@gmail.com","category":"Technology","likes":155,"dislikes":11,"tags":"cars, tire, automotive, wheels, repair","difficulty":1,"timeToComplete":"30 Minutes","sponsored":true},null]
/// pageable : {"sort":{"empty":true,"unsorted":true,"sorted":false},"offset":0,"pageNumber":0,"pageSize":20,"paged":true,"unpaged":false}
/// last : true
/// totalPages : 1
/// totalElements : 8
/// first : true
/// size : 20
/// number : 0
/// sort : {"empty":true,"unsorted":true,"sorted":false}
/// numberOfElements : 8
/// empty : false

class CommunityMadeInstructions {
  CommunityMadeInstructions({
      List<Content>? content, 
      Pageable? pageable, 
      bool? last, 
      num? totalPages, 
      num? totalElements, 
      bool? first, 
      num? size, 
      num? number, 
      Sort? sort, 
      num? numberOfElements, 
      bool? empty,}){
    _content = content;
    _pageable = pageable;
    _last = last;
    _totalPages = totalPages;
    _totalElements = totalElements;
    _first = first;
    _size = size;
    _number = number;
    _sort = sort;
    _numberOfElements = numberOfElements;
    _empty = empty;
}

  CommunityMadeInstructions.fromJson(dynamic json) {
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
    _pageable = json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    _last = json['last'];
    _totalPages = json['totalPages'];
    _totalElements = json['totalElements'];
    _first = json['first'];
    _size = json['size'];
    _number = json['number'];
    _sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    _numberOfElements = json['numberOfElements'];
    _empty = json['empty'];
  }
  List<Content>? _content;
  Pageable? _pageable;
  bool? _last;
  num? _totalPages;
  num? _totalElements;
  bool? _first;
  num? _size;
  num? _number;
  Sort? _sort;
  num? _numberOfElements;
  bool? _empty;
CommunityMadeInstructions copyWith({  List<Content>? content,
  Pageable? pageable,
  bool? last,
  num? totalPages,
  num? totalElements,
  bool? first,
  num? size,
  num? number,
  Sort? sort,
  num? numberOfElements,
  bool? empty,
}) => CommunityMadeInstructions(  content: content ?? _content,
  pageable: pageable ?? _pageable,
  last: last ?? _last,
  totalPages: totalPages ?? _totalPages,
  totalElements: totalElements ?? _totalElements,
  first: first ?? _first,
  size: size ?? _size,
  number: number ?? _number,
  sort: sort ?? _sort,
  numberOfElements: numberOfElements ?? _numberOfElements,
  empty: empty ?? _empty,
);
  List<Content>? get content => _content;
  Pageable? get pageable => _pageable;
  bool? get last => _last;
  num? get totalPages => _totalPages;
  num? get totalElements => _totalElements;
  bool? get first => _first;
  num? get size => _size;
  num? get number => _number;
  Sort? get sort => _sort;
  num? get numberOfElements => _numberOfElements;
  bool? get empty => _empty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    if (_pageable != null) {
      map['pageable'] = _pageable?.toJson();
    }
    map['last'] = _last;
    map['totalPages'] = _totalPages;
    map['totalElements'] = _totalElements;
    map['first'] = _first;
    map['size'] = _size;
    map['number'] = _number;
    if (_sort != null) {
      map['sort'] = _sort?.toJson();
    }
    map['numberOfElements'] = _numberOfElements;
    map['empty'] = _empty;
    return map;
  }

}

/// empty : true
/// unsorted : true
/// sorted : false

class Sort {
  Sort({
      bool? empty, 
      bool? unsorted, 
      bool? sorted,}){
    _empty = empty;
    _unsorted = unsorted;
    _sorted = sorted;
}

  Sort.fromJson(dynamic json) {
    _empty = json['empty'];
    _unsorted = json['unsorted'];
    _sorted = json['sorted'];
  }
  bool? _empty;
  bool? _unsorted;
  bool? _sorted;
Sort copyWith({  bool? empty,
  bool? unsorted,
  bool? sorted,
}) => Sort(  empty: empty ?? _empty,
  unsorted: unsorted ?? _unsorted,
  sorted: sorted ?? _sorted,
);
  bool? get empty => _empty;
  bool? get unsorted => _unsorted;
  bool? get sorted => _sorted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['empty'] = _empty;
    map['unsorted'] = _unsorted;
    map['sorted'] = _sorted;
    return map;
  }

}

/// sort : {"empty":true,"unsorted":true,"sorted":false}
/// offset : 0
/// pageNumber : 0
/// pageSize : 20
/// paged : true
/// unpaged : false

class Pageable {
  Pageable({
      Sort? sort, 
      num? offset, 
      num? pageNumber, 
      num? pageSize, 
      bool? paged, 
      bool? unpaged,}){
    _sort = sort;
    _offset = offset;
    _pageNumber = pageNumber;
    _pageSize = pageSize;
    _paged = paged;
    _unpaged = unpaged;
}

  Pageable.fromJson(dynamic json) {
    _sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    _offset = json['offset'];
    _pageNumber = json['pageNumber'];
    _pageSize = json['pageSize'];
    _paged = json['paged'];
    _unpaged = json['unpaged'];
  }
  Sort? _sort;
  num? _offset;
  num? _pageNumber;
  num? _pageSize;
  bool? _paged;
  bool? _unpaged;
Pageable copyWith({  Sort? sort,
  num? offset,
  num? pageNumber,
  num? pageSize,
  bool? paged,
  bool? unpaged,
}) => Pageable(  sort: sort ?? _sort,
  offset: offset ?? _offset,
  pageNumber: pageNumber ?? _pageNumber,
  pageSize: pageSize ?? _pageSize,
  paged: paged ?? _paged,
  unpaged: unpaged ?? _unpaged,
);
  Sort? get sort => _sort;
  num? get offset => _offset;
  num? get pageNumber => _pageNumber;
  num? get pageSize => _pageSize;
  bool? get paged => _paged;
  bool? get unpaged => _unpaged;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sort != null) {
      map['sort'] = _sort?.toJson();
    }
    map['offset'] = _offset;
    map['pageNumber'] = _pageNumber;
    map['pageSize'] = _pageSize;
    map['paged'] = _paged;
    map['unpaged'] = _unpaged;
    return map;
  }

}

/// empty : true
/// unsorted : true
/// sorted : false


/// id : 12
/// title : "2 How to change the tire on a car"
/// description : "This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry"
/// postCreatedAt : "2023-01-03T16:54:30.756846"
/// instructions : "Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on. Step 2: Locate the jack and the lug wrench. Step 3: Remove the lug nuts from the tire. Step 4: Place the jack under the car and raise it until the tire is off the ground. Step 5: Remove the tire and replace it with the spare. Step 6: Replace the lug nuts and tighten them. Step 7: Lower the car and remove the jack. Step 8: Replace the lug wrench and jack in their original locations. Step 9: Turn on the car and drive away. Step 10: Go to a tire shop to get the flat tire fixed."
/// createdBy : "bjharan7@gmail.com"
/// category : "Automotive"
/// likes : 155
/// dislikes : 11
/// tags : "cars, tire, automotive, wheels, repair"
/// difficulty : 3
/// timeToComplete : "30 Minutes"
/// sponsored : true

class Content {
  Content({
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

  Content.fromJson(dynamic json) {
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
Content copyWith({  num? id,
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
}) => Content(  id: id ?? _id,
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