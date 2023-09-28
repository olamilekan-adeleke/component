import 'package:equatable/equatable.dart';

class BaseEntity extends Equatable {
  final int status;
  final String state;
  final String message;
  final dynamic data;

  const BaseEntity({
    required this.state,
    required this.message,
    required this.status,
    this.data,
  });

  @override
  List<Object?> get props => [state, status, message, data];
}

class PaginationEntity extends Equatable {
  const PaginationEntity({
    required this.hasPrevious,
    required this.prevPage,
    required this.hasNext,
    required this.next,
    required this.currentPage,
    required this.pageSize,
    required this.lastPage,
    required this.total,
  });

  final bool hasPrevious;
  final int prevPage;
  final bool hasNext;
  final int next;
  final int currentPage;
  final int pageSize;
  final int lastPage;
  final int total;

  @override
  List<Object?> get props => [
        hasPrevious,
        prevPage,
        hasNext,
        next,
        currentPage,
        pageSize,
        lastPage,
        total,
      ];
}

///

class BaseModel extends BaseEntity {
  const BaseModel({
    required int status,
    required String state,
    required String message,
    dynamic data,
  }) : super(state: state, status: status, message: message, data: data);

  factory BaseModel.fromMap(Map<String, dynamic> json) {
    return BaseModel(
      status: json['status'] ?? 0,
      state: json['state'] ?? "",
      message: json['message'] ?? "",
      data: json['data'],
    );
  }
}

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required bool hasPrevious,
    required int prevPage,
    required bool hasNext,
    required int next,
    required int currentPage,
    required int pageSize,
    required int lastPage,
    required int total,
  }) : super(
          hasPrevious: hasPrevious,
          prevPage: prevPage,
          hasNext: hasNext,
          next: next,
          currentPage: currentPage,
          pageSize: pageSize,
          lastPage: lastPage,
          total: total,
        );

  factory PaginationModel.fromMap(Map<String, dynamic> json) {
    return PaginationModel(
      hasPrevious: json['hasPrevious'] ?? false,
      prevPage: json['prevPage'] ?? 0,
      hasNext: json['hasNext'] ?? false,
      next: json['next'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      lastPage: json['lastPage'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
