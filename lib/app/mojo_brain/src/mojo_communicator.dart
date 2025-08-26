part of mojo_brain;
//
// abstract class CleoCommunicator {
//   // -----------------------------------------------------------------------------
//
//   /// TITLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> onSend({
//     required Wire<bool> mounted,
//     required Wire<bool> userInputIsLoading,
//     required Wire<bool> cleoIsLoading,
//     required TextEditingController textController,
//     required String? text,
//     required String? userID,
//     required ChatSession? chatSession,
//     required Wire<List<DMModel>> dms,
//     required Wire<List<String>> buttons,
//     required String? conversationID,
//   }) async {
//
//     userInputIsLoading.set(value: true, mounted: mounted.value);
//
//     final String dmText = text ?? textController.text.trim();
//
//     _insertDM(
//       text: dmText,
//       userID: userID,
//       mounted: mounted,
//       dms: dms,
//       conversationID: conversationID,
//     );
//
//     textController.text = '';
//
//     /// FAKE PROCESSING TIME,,, TEMP SHIT, REMOVE ME ANYTIME DONT WORRY
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     userInputIsLoading.set(value: false, mounted: mounted.value);
//
//     cleoIsLoading.set(value: true, mounted: mounted.value);
//
//     final GenerateContentResponse? _generatedResponse = await _generateResponse(
//       chatSession: chatSession,
//       text: dmText,
//     );
//
//     final CleoResponseModel? _responseModel = CleoResponseModel.decipherContentResponse(
//       response: _generatedResponse,
//     );
//
//     final String? _responseText = _responseModel?.text;
//
//     buttons.set(
//       value: _responseModel?.choices ?? [],
//       mounted: mounted.value,
//     );
//
//     _insertDM(
//       text: _responseText,
//       userID: DMModel.cleoUserID,
//       dms: dms,
//       mounted: mounted,
//       conversationID: conversationID,
//     );
//
//     cleoIsLoading.set(value: false, mounted: mounted.value);
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<GenerateContentResponse?> _generateResponse({
//     required ChatSession? chatSession,
//     required String text,
//   }) async {
//     GenerateContentResponse? _generatedResponse;
//
//     await tryAndCatch(
//       invoker: '_generateResponse',
//       functions: () async {
//
//         _generatedResponse = await chatSession?.sendMessage(Content.text(text));
//         blog('functionCalls: (id) ${_generatedResponse?.functionCalls.firstOrNull?.id}');
//         blog('functionCalls: (name) ${_generatedResponse?.functionCalls.firstOrNull?.name}');
//
//         final List<FunctionResponse> _triggerResponses = await CleoTriggers.trigger(
//           generated: _generatedResponse,
//         );
//
//         if (Lister.checkCanLoop(_triggerResponses) == true){
//           _generatedResponse = await chatSession?.sendMessage(Content.functionResponses(_triggerResponses));
//         }
//
//       },
//     );
//
//     return _generatedResponse;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static void _insertDM({
//     required String? userID,
//     required String? text,
//     required Wire<List<DMModel>> dms,
//     required Wire<bool> mounted,
//     required String? conversationID,
//   }){
//
//
//     if (text == null){
//       blog('_insertDM.text($text)');
//     }
//
//     else {
//
//       final List<DMModel> _newDms = DMModel.insertNewDM(
//         dms: dms.value,
//         text: text,
//         userID: userID,
//       );
//
//       dms.set(
//         value: _newDms,
//         mounted: mounted.value,
//       );
//
//       CleoRecorder.recordDmSync(
//         conversationID: conversationID,
//         dm: _newDms.last,
//         index: _newDms.length - 1,
//       );
//
//     }
//
//   }
//   // -----------------------------------------------------------------------------
// }
