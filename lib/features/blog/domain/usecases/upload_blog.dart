// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

// Note : naming convention for a usecase is 'VerbNoun'

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  BlogRepository blogRepository;
  UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) {
    return blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
