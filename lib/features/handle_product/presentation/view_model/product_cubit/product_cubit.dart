import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taht_bety_provider/core/utils/app_fun.dart';
import 'package:taht_bety_provider/features/home/data/models/provider_model/post.dart';

import '../../../../home/data/repos/provider_profile_repo.dart';


part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.providerProfileRepo) : super(ProductInitial());
  final ProviderProfileRepo providerProfileRepo;

  Future<void> addProduct(
      {required List<File> images,
      required String title,
      required String content,
      required double price}) async {
    emit(ProductLoading());

    try {
      var post = await providerProfileRepo.addProduct(
        title: title,
        content: content,
        price: price,
        images: await Future.wait(
            images.map((image) => AppFun.imageToBase64(image))),
        isMainService: false,
      );
      emit(AddProduct());
      post.fold(
        (failure) => emit(ProductFailure(failure.failurMsg)),
        (post) => emit(ProductSuccess(post)),
      );
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  Future<void> updateProduct({required Post product}) async {
    emit(ProductLoading());
    try {
      var post = await providerProfileRepo.updateProduct(
        postId: product.id!,
        title: product.title!,
        content: product.content!,
        price: product.price!.toDouble(),
        images: product.images!,
        isMainService: product.isMainService!,
      );
      emit(UpdateProduct());
      post.fold(
        (failure) => emit(ProductFailure(failure.failurMsg)),
        (post) => emit(ProductSuccess(post)),
      );
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  
      
  }

  Future<void> deleteProduct({required String postId}) async {
    emit(ProductLoading());
    try {
      var post = await providerProfileRepo.deleteProduct(
        postId: postId,
      );
      emit(DeleteProduct());
      post.fold(
        (failure) => emit(ProductFailure(failure.failurMsg)),
        (post) => emit(ProductSuccess(post)),
      );
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
