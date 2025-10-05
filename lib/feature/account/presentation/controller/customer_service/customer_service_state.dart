part of 'customer_service_bloc.dart';

class CustomerServiceState extends Equatable {
  final List<Message> chatMessage;
  final bool isLoading;
  final String errorMessage;
  final String filePath;
  final int userID;
  final bool isRecord;
  final double loading;
  const CustomerServiceState({
    this.chatMessage = const [],
    this.errorMessage = '',
    this.isLoading = true,
    this.filePath = "",
    this.userID = 0,
    this.isRecord = false,
    this.loading = 0.0,
  });
  CustomerServiceState copyWith({
    List<Message>? chatMessage,
    String? errorMessage,
    String? filePath,
    bool? isLoading,
    int? userID,
    bool? isRecord,
    double? loading,
  }) {
    return CustomerServiceState(
      chatMessage: chatMessage ?? this.chatMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      filePath: filePath ?? this.filePath,
      isLoading: isLoading ?? this.isLoading,
      userID: userID ?? this.userID,
      isRecord: isRecord ?? this.isRecord,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [
        chatMessage,
        userID,
        filePath,
        isLoading,
        errorMessage,
        isRecord,
        loading,
      ];
}

final class CustomerServiceInitial extends CustomerServiceState {}
