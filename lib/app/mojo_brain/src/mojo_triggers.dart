part of mojo_brain;
// /// => TAMAM
// abstract class CleoTriggers {
//   // --------------------------------------------------------------------------
//
//   /// TOOLS
//
//   // --------------------
//   static final List<Tool> tools = <Tool>[
//     Tool.functionDeclarations([
//       // CleoTriggers.showLoadingTool,
//       createQuestionTool,
//       routeToMyQuestionsPageTool,
//       pickCompanyTool,
//     ]),
//   ];
//   // --------------------
//   static final ToolConfig toolConfigs = ToolConfig(
//     functionCallingConfig: FunctionCallingConfig.auto(),
//   );
//   // --------------------------------------------------------------------------
//
//   /// TRIGGER
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<FunctionResponse>> trigger({
//     required GenerateContentResponse? generated,
//   }) async {
//     List<FunctionResponse> _output = [];
//
//     final List<FunctionCall>? _functionCalls = generated?.functionCalls.toList();
//
//     if (Lister.checkCanLoop(_functionCalls) == true){
//
//       await Lister.loop(
//         models: _functionCalls!,
//         onLoop: (int index, FunctionCall? functionCall) async {
//
//           if (functionCall != null){
//
//             /// SHOW LOADING
//             if (functionCall.name == cleoTriggerShowLoading){
//               _output = await _addResponse(
//                 responses: _output,
//                 response: await showLoadingFunction(functionCall: functionCall),
//               );
//             }
//
//             /// PICK A COMPANY
//             if (functionCall.name == cleoTriggerPickCompany){
//               _output = await _addResponse(
//                 responses: _output,
//                 response: await pickCompanyFunction(functionCall: functionCall),
//               );
//             }
//
//             /// CREATE QUESTION
//             if (functionCall.name == cleoTriggerCreateQuestion){
//               _output = await _addResponse(
//                 responses: _output,
//                 response: await createQuestionFunction(functionCall: functionCall),
//               );
//             }
//
//             /// ROUTE TO MY QUESTIONS
//             if (functionCall.name == cleoTriggerRouteToMyQuestionsPage){
//               _output = await _addResponse(
//                 responses: _output,
//                 response: await routeToMyQuestionsFunction(functionCall: functionCall),
//               );
//             }
//
//           }
//
//         },
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<List<FunctionResponse>> _addResponse({
//     required List<FunctionResponse> responses,
//     required FunctionResponse? response,
//   }) async {
//
//     if (response == null){
//       return responses;
//     }
//     else {
//       return [...responses, response];
//     }
//
//   }
//   // --------------------------------------------------------------------------
//
//   /// LOADING
//
//   // --------------------
//   static String cleoTriggerShowLoading = 'cleoTriggerShowLoading';
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FunctionDeclaration showLoadingTool = FunctionDeclaration(
//     cleoTriggerShowLoading,
//     'show loading UI for 3 seconds',
//     parameters: {
//       'loadingText': Schema.string(
//         nullable: true,
//         description: 'text shown on screen while loading',
//       ),
//       'reply': Schema.string(
//         nullable: true,
//         description: 'the function response to the operation for feedback',
//       ),
//     },
//   );
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<FunctionResponse?> showLoadingFunction({
//     required FunctionCall functionCall,
//   }) async {
//     FunctionResponse? _output;
//
//     await Waiter.sandwich(
//         function: () async {
//
//           await Waiter.microWait(durationMs: 3000, index: 1);
//
//           _output = FunctionResponse(
//             functionCall.name,
//             {
//               'reply': 'the operation was interrupted',
//             },
//             id: cleoTriggerShowLoading,
//           );
//
//         });
//
//     return _output;
//   }
//   // --------------------------------------------------------------------------
//
//   /// CREATE QUESTION
//
//   // --------------------
//   static String cleoTriggerPickCompany = 'cleoTriggerPickCompany';
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FunctionDeclaration pickCompanyTool = FunctionDeclaration(
//     cleoTriggerPickCompany,
//     'shows a dialog of list of user companies for the user to pick one of them',
//     parameters: {
//       'reply': Schema.string(description: 'the function response to the operation for feedback', nullable: true),
//       'askerBzID': Schema.string(description: 'the business ID selected by the user', nullable: true),
//     },
//   );
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<FunctionResponse?> pickCompanyFunction({
//     required FunctionCall functionCall,
//   }) async {
//
//     // final Map<String, dynamic> args = functionCall.args;
//
//     String? _bzID;
//     String? _bzName;
//
//     await Waiter.sandwich(
//       function: () async {
//
//         final UserModel? _userModel = UserPro.proGetMyUserModel();
//         if (Lister.checkCanLoop(_userModel?.myBzzIDs) == true){
//
//           final List<BzModel> _bzz = await BzFetchProtocols.fetchBzz(
//             bzzIDs: _userModel?.myBzzIDs,
//             major: false,
//           );
//
//           final BzModel? _bzModel = await BzDialog.selectBzBottomDialog(
//             context: getTheMainContext(),
//             bzzModels: _bzz,
//           );
//
//           _bzID = _bzModel?.id;
//           _bzName = _bzModel?.name;
//
//         }
//
//       },
//     );
//
//     return FunctionResponse(
//       functionCall.name,
//       {
//         'reply': _bzID == null ? 'could not pick a company' : 'we picked company id ($_bzID) company name is ($_bzName)',
//         'askerBzID': _bzID,
//       },
//       id: cleoTriggerPickCompany,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// CREATE QUESTION
//
//   // --------------------
//   static String cleoTriggerCreateQuestion = 'cleoTriggerCreateQuestion';
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FunctionDeclaration createQuestionTool = FunctionDeclaration(
//     cleoTriggerCreateQuestion,
//     'creates a QuestionModel then routes user to QuestionEditor screen to confirm and publish his question',
//     parameters: {
//       'reply': Schema.string(
//         nullable: true,
//         description: 'the function response to the operation for feedback',
//       ),
//       'phase': Schema.string(description: 'Project phase like lookingForProperty, planningConstruction, underConstruction, or furnishing.'),
//       'text': Schema.string(description: 'The full description of the user’s project needs'),
//       'summery': Schema.string(description: 'A short summery for the question details', nullable: true),
//       'mediaURLs': Schema.array(items: Schema.string(), description: 'Optional media URLs.', nullable: true),
//       'phids': Schema.array(items: Schema.string(), description: 'List of keyword IDs relevant to the question.'),
//       'type': Schema.string(description: 'Question type: requestForInfo or requestForPrice.', nullable: true),
//       'askerID': Schema.string(description: "The id field of the asker's UserModel not his name", nullable: true),
//       'askerBzID': Schema.string(description: 'the business ID If user represents a business.', nullable: true),
//       'isb2b': Schema.boolean(description: 'Whether it’s a business-to-business question.', nullable: true),
//       'countryID': Schema.string(description: 'the ISO3 country ID of the asker', nullable: true),
//       'cityID': Schema.string(description: 'the cityID of the asker', nullable: true),
//       'contacts': Schema.object(
//         description: 'Map of user contact methods. Keys can include:\n'
//             '• phone, email, website\n'
//             '• facebook, linkedIn, youtube, instagram, pinterest, tiktok, twitter, snapchat, behance, vimeo\n'
//             '• map, telegram\n'
//             '• appStore, googlePlay, appGallery\n'
//             'Each value should be a string (e.g. phone number, email, or URL).',
//         properties: {
//           'phone':       Schema.string(nullable: true),
//           'email':       Schema.string(nullable: true),
//           'website':     Schema.string(nullable: true),
//           'facebook':    Schema.string(nullable: true),
//           'linkedIn':    Schema.string(nullable: true),
//           'youtube':     Schema.string(nullable: true),
//           'instagram':   Schema.string(nullable: true),
//           'pinterest':   Schema.string(nullable: true),
//           'tiktok':      Schema.string(nullable: true),
//           'twitter':     Schema.string(nullable: true),
//           'snapchat':    Schema.string(nullable: true),
//           'behance':     Schema.string(nullable: true),
//           'vimeo':       Schema.string(nullable: true),
//           'map':         Schema.string(nullable: true),
//           'telegram':    Schema.string(nullable: true),
//           'appStore':    Schema.string(nullable: true),
//           'googlePlay':  Schema.string(nullable: true),
//           'appGallery':  Schema.string(nullable: true),
//         },
//       ),
//
//     },
//   );
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<FunctionResponse?> createQuestionFunction({
//     required FunctionCall functionCall,
//   }) async {
//
//     final Map<String, dynamic> args = functionCall.args;
//
//     final QuestionModel _questionModel = QuestionModel(
//       id: Idifier.createUniqueIDString(),
//       text: args['text'],
//       summery: args['summery'],
//       mediaURLs: List<String>.from(args['mediaURLs'] ?? []),
//       contacts: ContactModel.decipherContacts(Mapper.getMapFromIHLMOO(ihlmoo: args['contacts'])),
//       phids: List<String>.from(args['phids']),
//       phase: QuestionModel.decipherProjectPhase(args['phase']),
//       type: QuestionModel.decipherQuestionType(args['type']),
//       zone: ZoneModel(
//         countryID: args['countryID'],
//         cityID: args['cityID'],
//       ),
//       askerID: args['askerID'],
//       askerBzID: args['askerBzID'],
//       isb2b: args['isb2b'] ?? false,
//       time: DateTime.now(),
//       views: 0,
//       chatsIDs: const [],
//     );
//
//     blog('question');
//     blog(_questionModel);
//
//     final QuestionModel? _uploaded = await QuestionEditorScreen.createNewQuestionFromCleo(
//       question: _questionModel,
//     );
//
//     return FunctionResponse(
//       functionCall.name,
//       {
//         'reply': _uploaded == null ? 'could not create question' : 'question was created successfully',
//       },
//       id: cleoTriggerCreateQuestion,
//     );
//   }
//   // --------------------------------------------------------------------------
//
//   /// CREATE QUESTION
//
//   // --------------------
//   static String cleoTriggerRouteToMyQuestionsPage = 'cleoTriggerRouteToMyQuestionsPage';
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FunctionDeclaration routeToMyQuestionsPageTool = FunctionDeclaration(
//     cleoTriggerRouteToMyQuestionsPage,
//     'routes the user to his questions list page after successfully submitting a question',
//     parameters: {
//       'reply': Schema.string(
//         nullable: true,
//         description: 'the function response to the operation for feedback',
//       ),
//       'askerBzID': Schema.string(description: 'the business ID If user represents a business.', nullable: true),
//       'isb2b': Schema.boolean(description: 'Whether it’s a business-to-business question.', nullable: true),
//     },
//   );
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<FunctionResponse?> routeToMyQuestionsFunction({
//     required FunctionCall functionCall,
//   }) async {
//
//     final Map<String, dynamic> args = functionCall.args;
//     final String? _bzID = args['askerBzID'];
//     final bool _isB2B = args['isb2b'] ?? false;
//
//     /// USER QUESTION
//     if (_bzID == null || _isB2B == false){
//       await Routing.goTo(invoker: 'routeToMyQuestionsFunction', route: TabName.bid_My_Asks);
//     }
//
//     /// MY BZ QUESTION
//     else {
//       await Routing.goTo(invoker: 'routeToMyQuestionsFunction', route: TabName.bid_MyBz_Asks, arg: _bzID);
//     }
//
//     return null;
//   }
//   // --------------------------------------------------------------------------
// }

/*
search flyers
search bzz
attach AVs
*/
