import 'base_api.dart';

class ObtainedResponse<A> {
  final API_RESULT result;
  final A data;

  ObtainedResponse(this.result, this.data);
}