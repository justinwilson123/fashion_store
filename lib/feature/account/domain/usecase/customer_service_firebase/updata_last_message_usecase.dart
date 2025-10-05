import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

class UpdataLastMessageUsecase {
  final CustomerServiceRepositoryFirebase customerService;
  UpdataLastMessageUsecase(this.customerService);
  // Future<Either<Failure, Unit>> call(
  //     String userID, LastMessageEntity lastMessage) async {
  //   return await customerService.upDateLastMessage(userID, lastMessage);
  // }
}
