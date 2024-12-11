class PostDTO {

 final int? Id;
 final String Title;
 final String Body;
 
 PostDTO({ this.Id, required this.Title, required this.Body});

 factory PostDTO.fromJson(Map<String, dynamic> json)
  => PostDTO(Id: json['id'], Title: json['title'], Body: json['body']);
  

  Map<String, dynamic> toJson()=> {'id': Id, 'title': Title, 'body': Body};  

}