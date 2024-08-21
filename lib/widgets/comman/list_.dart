import 'package:flutter/material.dart';
import 'package:mini_social_media_app/model/post_model.dart';

class DemoPosts {
  ValueNotifier<List<PostModel>> posts = ValueNotifier<List<PostModel>>([
    PostModel(
      image: 'assets/images/download (1).jpeg',
      title: 'Title 1',
      description: 'Description for item 1',
    ),
    PostModel(
      image: 'assets/images/download (2).jpeg',
      title: 'Title 2',
      description: 'Description for item 2',
    ),
    PostModel(
      image: 'assets/images/download (3).jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/download (4).jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/download (5).jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/download (6).jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/download.jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/Frame 2 (1).png',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/images (2).jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
    PostModel(
      image: 'assets/images/images.jpeg',
      title: 'Title 3',
      description: 'Description for item 3',
    ),
  ]);

  void addPost(String image, String title, String description) {
    posts.value
        .add(PostModel(image: image, title: title, description: description));
    // ignore: invalid_use_of_protected_member
    posts.notifyListeners();
  }
}

DemoPosts demoPosts = DemoPosts();
