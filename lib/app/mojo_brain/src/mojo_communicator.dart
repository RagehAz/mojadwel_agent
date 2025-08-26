part of mojo_brain;

// abstract class MojoCommunicator {
//   // -----------------------------------------------------------------------------
//
//   /// TITLE
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> onSend({
//     required String text,
//     required String? userID,
//     required ChatSession? chatSession,
//     required List<DMModel> dms,
//     // required List<String> buttons,
//     required String? conversationID,
//   }) async {
//
//     final String dmText = text.trim();
//
//     _insertDM(
//       text: dmText,
//       userID: userID,
//       dms: dms,
//       conversationID: conversationID,
//     );
//
//     // userInputIsLoading.set(value: false, mounted: mounted.value);
//
//     // cleoIsLoading.set(value: true, mounted: mounted.value);
//
//     final GenerateContentResponse? _generatedResponse = await _generateResponse(
//       chatSession: chatSession,
//       text: dmText,
//     );
//
//     final MojoResponseModel? _responseModel = MojoResponseModel.decipherContentResponse(
//       response: _generatedResponse,
//     );
//
//     final String? _responseText = _responseModel?.text;
//
//     // buttons.set(
//     //   value: _responseModel?.choices ?? [],
//     //   mounted: mounted.value,
//     // );
//
//     _insertDM(
//       text: _responseText,
//       userID: 'x',
//       dms: dms,
//       conversationID: conversationID,
//     );
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
//         // final List<FunctionResponse> _triggerResponses = await CleoTriggers.trigger(
//         //   generated: _generatedResponse,
//         // );
//
//         // if (Lister.checkCanLoop(_triggerResponses) == true){
//         //   _generatedResponse = await chatSession?.sendMessage(Content.functionResponses(_triggerResponses));
//         // }
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
//     required List<DMModel> dms,
//     required String? conversationID,
//   }){
//
//
//     // if (text == null){
//     //   blog('_insertDM.text($text)');
//     // }
//     //
//     // else {
//     //
//     //   final List<DMModel> _newDms = DMModel.insertNewDM(
//     //     dms: dms.value,
//     //     text: text,
//     //     userID: userID,
//     //   );
//     //
//     //   dms.set(
//     //     value: _newDms,
//     //     mounted: mounted.value,
//     //   );
//     //
//     //   CleoRecorder.recordDmSync(
//     //     conversationID: conversationID,
//     //     dm: _newDms.last,
//     //     index: _newDms.length - 1,
//     //   );
//     //
//     // }
//
//   }
//   // -----------------------------------------------------------------------------
// }
