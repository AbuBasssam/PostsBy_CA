import 'package:equatable/equatable.dart';

class Post extends Equatable
{
 final int Id;
 final String Title;
 final String Body;
 
 Post({required this.Id, required this.Title, required this.Body});
  
 @override
 List<Object?> get props => [Id,Title,Body];
}