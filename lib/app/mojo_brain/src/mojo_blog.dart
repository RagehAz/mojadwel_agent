// // ignore_for_file: avoid_types_as_parameter_names
part of mojo_brain;
//
// abstract class CleoBlog {
//   // --------------------------------------------------------------------------
//
//   /// BLOG
//
//   // --------------------
//   static void blogGenerateContentResponse(GenerateContentResponse? response){
//
//     if (response == null){
//       blog('response is null');
//     }
//     else {
//
//       blog('blogGenerateContentResponse.response.text(${response.text})');
//
//       /// candidates
//       Lister.loopSync(
//         models: response.candidates,
//         onListIsEmpty: (){
//           blog('blogGenerateContentResponse.response.candidates.isEmpty');
//         },
//         onLoop: (int index, Candidate? candidate){
//           blog('blogGenerateContentResponse.index[$index].candidate?.safetyRatings(${candidate?.safetyRatings})');
//           blog('blogGenerateContentResponse.index[$index].candidate.text(${candidate?.text})');
//           blog('blogGenerateContentResponse.index[$index].candidate.citationMetadata(${candidate?.citationMetadata})');
//           blog('blogGenerateContentResponse.index[$index].candidate.content(${candidate?.content})');
//           blog('blogGenerateContentResponse.index[$index].candidate.finishMessage(${candidate?.finishMessage})');
//           blog('blogGenerateContentResponse.index[$index].candidate.finishReason(${candidate?.finishReason})');
//         },
//       );
//
//       /// functionCalls
//       Lister.loopSync(
//         models: [...response.functionCalls],
//         onListIsEmpty: (){
//           blog('blogGenerateContentResponse.response.functionCalls.isEmpty');
//         },
//         onLoop: (int index, FunctionCall? functionCall){
//           blog('blogGenerateContentResponse.index[$index].functionCall?.name(${functionCall?.name})');
//           blog('blogGenerateContentResponse.index[$index].functionCall.id(${functionCall?.id})');
//         },
//       );
//
//       /// inlineDataParts
//       Lister.loopSync(
//         models: <InlineDataPart>[...response.inlineDataParts],
//         onListIsEmpty: (){
//           blog('blogGenerateContentResponse.response.inlineDataParts.isEmpty');
//         },
//         onLoop: (int index, InlineDataPart? part){
//           blog('blogGenerateContentResponse.index[$index].part?.mimeType(${part?.mimeType})');
//           blog('blogGenerateContentResponse.index[$index].part.bytes.length(${part?.bytes.length})');
//           blog('blogGenerateContentResponse.index[$index].part.willContinue(${part?.willContinue})');
//         },
//       );
//
//       blog('blogGenerateContentResponse.response.promptFeedback?.blockReason(${response.promptFeedback?.blockReason})');
//       blog('blogGenerateContentResponse.response.promptFeedback?.blockReasonMessage(${response.promptFeedback?.blockReasonMessage})');
//
//       /// safetyRatings
//       Lister.loopSync(
//         models: <SafetyRating>[...?response.promptFeedback?.safetyRatings],
//         onListIsEmpty: (){
//           blog('blogGenerateContentResponse.response.promptFeedback?.safetyRatings.isEmpty');
//         },
//         onLoop: (int index, SafetyRating? rating){
//           blog('blogGenerateContentResponse.index[$index].rating?.category(${rating?.category}');
//           blog('blogGenerateContentResponse.index[$index].rating?.isBlocked(${rating?.isBlocked}');
//           blog('blogGenerateContentResponse.index[$index].rating?.probability(${rating?.probability}');
//           blog('blogGenerateContentResponse.index[$index].rating?.probabilityScore(${rating?.probabilityScore}');
//           blog('blogGenerateContentResponse.index[$index].rating?.severity(${rating?.severity}');
//           blog('blogGenerateContentResponse.index[$index].rating?.severityScore(${rating?.severityScore}');
//         },
//       );
//
//
//       /// candidatesTokenCount
//       blog('blogGenerateContentResponse.usageMetadata.candidatesTokenCount(${response.usageMetadata?.candidatesTokenCount})');
//
//
//       /// candidatesTokensDetails
//       Lister.loopSync(
//         models: response.usageMetadata?.candidatesTokensDetails,
//         onListIsEmpty: () {
//           blog('blogGenerateContentResponse.usageMetadata.candidatesTokensDetails.isEmpty');
//         },
//         onLoop: (int index, count) {
//           blog('blogGenerateContentResponse.usageMetadata.candidatesTokensDetails[$index].modality(${count?.modality})');
//           blog('blogGenerateContentResponse.usageMetadata.candidatesTokensDetails[$index].count(${count?.tokenCount})');
//         },
//       );
//
//
//       /// promptTokenCount
//       blog('blogGenerateContentResponse.usageMetadata.promptTokenCount(${response.usageMetadata?.promptTokenCount})');
//
//       /// promptTokensDetails
//       Lister.loopSync(
//         models: response.usageMetadata?.promptTokensDetails,
//         onListIsEmpty: () {
//           blog('blogGenerateContentResponse.usageMetadata.promptTokensDetails.isEmpty');
//         },
//         onLoop: (int index, count) {
//           blog('blogGenerateContentResponse.usageMetadata.promptTokensDetails[$index].modality(${count?.modality})');
//           blog('blogGenerateContentResponse.usageMetadata.promptTokensDetails[$index].count(${count?.tokenCount})');
//         },
//       );
//
//       /// totalTokenCount
//       blog('blogGenerateContentResponse.usageMetadata.totalTokenCount(${response.usageMetadata?.totalTokenCount})');
//
//
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//   static void blog(dynamic msg, {String? invoker}){
//
//     const bool isDebug = !bool.fromEnvironment('dart.vm.product');
//
//     assert((){
//       if (isDebug) {
//         print(msg);
//       }
//       return true;
//     }(), '_');
//
//   }
//   // --------------------------------------------------------------------------
// }
