import 'package:rekrutacja_ai_native/data/repositories/llm_repository.dart';

class GetAiResponseUseCase {
  final LLMRepository repository;

  const GetAiResponseUseCase(this.repository);

  Future<String> call(String prompt) async {
    return repository.getLLMResponse(prompt);
  }
}
