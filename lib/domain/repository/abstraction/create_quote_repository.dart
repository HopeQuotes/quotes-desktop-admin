import '../../models/state/domain_result.dart';

abstract class QuoteRepository {
  Stream<DomainResult> createQuote(
      String author, String body, List<String> hashtags);

  Stream<DomainResult> getHashtags(int page);

  Stream<DomainResult> deleteQuote();

  Stream<DomainResult> getQuotes(int page);
}
