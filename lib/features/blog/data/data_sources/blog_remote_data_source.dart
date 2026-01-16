import 'dart:io';

import 'package:bloc_app/core/constants/supabase_schema/buckets.dart';
import 'package:bloc_app/core/constants/supabase_schema/fields/profile_fields.dart';
import 'package:bloc_app/core/constants/supabase_schema/tables.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({required File image, required String blogId});
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final List<Map<String, dynamic>> blogData = await supabaseClient
          .from(Tables.blogs)
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  }) async {
    try {
      await supabaseClient.storage
          .from(Buckets.blogImages)
          .upload(blogId, image);
      return supabaseClient.storage
          .from(Buckets.blogImages)
          .getPublicUrl(blogId);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final List<Map<String, dynamic>> rawBlogs = await supabaseClient
          .from(Tables.blogs)
          .select('*, profiles (name)');

      return rawBlogs
          .map(
            (rawBlog) => BlogModel.fromJson(rawBlog).copyWith(
              posterName: rawBlog[Tables.profiles][ProfileFields.name],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
