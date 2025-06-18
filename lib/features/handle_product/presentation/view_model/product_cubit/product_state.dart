part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {}

final class ProductFailure extends ProductState {
  final String failureMssg;
  const ProductFailure(this.failureMssg);
}

final class AddProduct extends ProductState {}

final class UpdateProduct extends ProductState {}

final class DeleteProduct extends ProductState {}
