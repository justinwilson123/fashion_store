import 'package:dartz/dartz.dart';
import 'package:fashion/core/error/failure.dart';
import 'package:fashion/feature/account/domain/repositories/customer_service_repository.dart';

class SendVoiceUseCase {
  final CustomerServiceRepositoryFirebase customerServiceRepository;
  SendVoiceUseCase(this.customerServiceRepository);
  Future<Either<Failure, Stream<double>>> call(String filePath) async {
    return await customerServiceRepository.sendVoice(filePath);
  }
}
