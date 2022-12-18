import 'package:admin/domain/models/ui/id_value.dart';
import 'package:admin/domain/models/ui/quote.dart';

import '../../models/state/domain_result.dart';

abstract class QuoteRepository {
  Stream<DomainResult> createQuote(String author, String body,
      List<String> hashtags, String photoId, String stateId);

  Stream<DomainResult> analyzeQuotesFile(String path, String splitBy);

  Stream<DomainResult> createQuotes(String author, List<IdValue> hashtags,
      List<String> photoIds, List<String> contents, String stateId);

  Stream<DomainResult> getHashtags(int page);

  Stream<DomainResult> getImages();

  Stream<DomainResult> deleteQuote();

  Stream<DomainResult> getQuoteStates();

  Stream<DomainResult> getQuotes(int page);
}
