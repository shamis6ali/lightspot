import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RequestState<T> extends Equatable {
  final bool isLoading, isSuccess, isError, isPagingLoading;
  final T? data;
  final String? message;

  const RequestState._({
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
    required this.isPagingLoading,
    required this.data,
    required this.message,
  });

  factory RequestState.initial() {
    return RequestState._(
      isLoading: false,
      isSuccess: false,
      isError: false,
      isPagingLoading: false,
      data: null,
      message: null,
    );
  }

  factory RequestState.loading({bool pagingLoading = false , T? data}) {
    return RequestState._(
      isLoading: !pagingLoading,
      isSuccess: false,
      isError: false,
      isPagingLoading: pagingLoading,
      data: data,
      message: null,
    );
  }

  factory RequestState.success(T? data) {
    return RequestState._(
      isLoading: false,
      isSuccess: true,
      isError: false,
      isPagingLoading: false,
      data: data,
      message: null,
    );
  }

  factory RequestState.error(String errorMessage) {
    return RequestState._(
      isLoading: false,
      isSuccess: false,
      isError: true,
      isPagingLoading: false,
      data: null,
      message: errorMessage,
    );
  }

  Widget build({
    required Widget Function(T data) successBuilder,
    Function()? onRetry,
    Widget Function(String message)? errorWidget,
    Widget? loadingWidget,
  }) {
    if (isLoading) {
      return loadingWidget ?? const SizedBox.shrink();
    } else if (isError) {
      if (errorWidget != null) {
        return errorWidget(message ?? '');
      } else {
        // You can replace this with your default error widget
        return SizedBox.shrink();
      }
    } else if (isSuccess) {
      return successBuilder(data as T);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildSliver({
    required Widget Function(T data) successBuilder,
    Function()? onRetry,
    Widget Function(String message)? errorWidget,
    Widget? loadingWidget,
  }) {
    return this.isLoading
        ? SliverToBoxAdapter(child: loadingWidget ?? CircularProgressIndicator.adaptive())
        : this.isError
            ? (errorWidget != null
                ? errorWidget(this.message ?? 'Error')
                : SliverToBoxAdapter(child: Text(this.message ?? 'Error')))
            : successBuilder(this.data as T);
    // : PagingLoading(
    //     isPaging: this.isPagingLoading,
    //     child: successBuilder(this.data!),
    //   );
  }

  void listen({
    Function(T data, String? message)? onSuccess,
    Function(String message)? onError,
    Function()? onLoading,
  }) {
    if (isSuccess) {
      onSuccess?.call(data as T, message);
    } else if (isError) {
      onError?.call(message ?? 'Error');
    } else if (isLoading) {
      onLoading?.call();
    }
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, isError, isPagingLoading, data, message];
}