import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/models/request/create_quote_request.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/quote_repository.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> createQuote(
      String author, String body, List<String> hashtags) async* {
    try {
      yield DomainLoading();
      if (author.trim().isEmpty || body.isEmpty || hashtags.isEmpty) {
        yield DomainValidationError(
            message: 'Malumotlarni oxirigacha toldiring !');
      } else {
        var response = await (await _client.request()).post('quote/create',
            data: CreateQuoteRequest(
                    author: '', text: '', hashtagIds: [], photoId: '')
                .toJson());
        if (response.statusCode == 200) {
          yield DomainSuccess();
        } else {
          yield DomainError(message: 'Xatolik yuz berdi...');
        }
      }
    } catch (e) {
      yield DomainError();
    }
  }

  @override
  Stream<DomainResult> deleteQuote() {
    // TODO: implement deleteQuote
    throw UnimplementedError();
  }

  @override
  Stream<DomainResult> getQuotes(int page) {
    // TODO: implement getQuotes
    throw UnimplementedError();
  }

  QuoteRepositoryImpl({
    required DioClient client,
  }) : _client = client;
}
