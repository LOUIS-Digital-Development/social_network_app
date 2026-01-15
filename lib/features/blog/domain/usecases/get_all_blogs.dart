import 'package:bloc_app/core/error/failures.dart';
import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  BlogRepository blogRepository;
  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) {
    return blogRepository.getAllBlogs();
  }
}
