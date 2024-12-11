import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_ca/Core/Errors/Exceptions.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPLocalDataSource.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_POSTS = "CACHED_POSTS";

class PLocalDataSource implements IPLocalDataSource
{
    final SharedPreferences sharedPreferences;

  PLocalDataSource({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostDTO> postModels) {
    List postModelsToJson = postModels.map<Map<String, dynamic>>((postModel) => postModel.toJson()).toList();
    
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    
    return Future.value(unit);
  }

  @override
  Future<List<PostDTO>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null)
    {
      List decodeJsonData = json.decode(jsonString);
      List<PostDTO> jsonToPostModels = decodeJsonData.map<PostDTO>((jsonPostModel) => PostDTO.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModels);
    }
    
    throw EmptyCacheException();
    
  }
 
  
}
 
