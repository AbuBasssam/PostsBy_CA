import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_ca/Core/Errors/Exceptions.dart';
import 'package:post_ca/Features/Post/Domain/Abstracts/IPRemoteDataSource.dart';
import 'package:post_ca/Features/Post/Infrastructure/Models/PostDTO.dart';
import 'package:http/http.dart' as http;



const BASE_URL = "https://jsonplaceholder.typicode.com";

class PRemoteDataSource implements IPRemoteDataSource
{

    final http.Client client;

  PRemoteDataSource({required this.client});
  @override
  Future<List<PostDTO>> getAllPosts() async {
    final response = await client.get
    (
      Uri.parse(BASE_URL + "/posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200)
    {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostDTO> postModels = decodedJson.map<PostDTO>((jsonPostModel) => PostDTO.fromJson(jsonPostModel)).toList();

      return postModels;
    }
    
    throw ServerException();
    
  }

  @override
  Future<Unit> addPost(PostDTO postModel) async {
    final body =
    {
      "title": postModel.Title,
      "body": postModel.Body,
    };

    final response =await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);

    if (response.statusCode == 201)
    {
      return Future.value(unit);
    } 
    
    throw ServerException();
    
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete
    (
      Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200)
    {
      return Future.value(unit);
    } 
    
    throw ServerException();
    
  }

  @override
  Future<Unit> updatePost(PostDTO postModel) async {
    final postId = postModel.Id.toString();
    final body =
    {
      "title": postModel.Title,
      "body": postModel.Body,
    };

    final response = await client.patch
    (
      Uri.parse(BASE_URL + "/posts/$postId"),
      body: body,
    );

    if (response.statusCode == 200)
    {
      return Future.value(unit);
    }

    throw ServerException();
    
  }
  
}

