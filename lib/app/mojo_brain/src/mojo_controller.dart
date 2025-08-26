part of mojo_brain;
//
// class CleoController {
//   // --------------------------------------------------------------------------
//
//   /// VARIABLES
//
//   // --------------------
//   String? _conversationID;
//   final TextEditingController textController = TextEditingController();
//   final Wire<List<String>> buttons = Wire<List<String>>([]);
//   final Wire<bool> cleoIsLoading = Wire<bool>(false);
//   final Wire<bool> userInputIsLoading = Wire<bool>(false);
//   final Wire<List<DMModel>> dms = Wire<List<DMModel>>([]);
//   final ScrollController scrollController = ScrollController();
//   // --------------------
//   final Wire<CensusModel?> census = Wire<CensusModel?>(null);
//   // --------------------
//   Wire<bool> mounted = Wire<bool>(true);
//   // --------------------------------------------------------------------------
//
//   /// AI VARIABLES
//
//   // --------------------
//   GenerativeModel? model;
//   // --------------------
//   ChatSession? _chatSession;
//   List<Content> history = <Content>[];
//   // -----------------------------------------------------------------------------
//
//   /// INIT
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void init(){
//
//     _conversationID = Idifier.createUniqueIDString();
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> onDidChangeDependencies() async {
//
//     census.set(
//       mounted: mounted.value,
//       value: await CensusProtocols.fetchPlanetCensus(),
//     );
//
//     final List<TextPart> _instructionParts = await CleoInitialInstructions.cleoInitialInstructions(
//       census: census.value,
//     );
//
//     model = FirebaseAI.vertexAI(
//       // location: ,
//       // app: ,
//       // appCheck: ,
//       // auth: ,
//     ).generativeModel(
//       model: 'gemini-2.5-flash',
//       generationConfig: CleoInitialInstructions.configs,
//       // safetySettings: [
//       //   SafetySetting(),
//       // ],
//       tools: CleoTriggers.tools,
//       toolConfig: CleoTriggers.toolConfigs,
//       systemInstruction: Content('system', _instructionParts),
//     );
//
//     _chatSession = model?.startChat(
//       history: history,
//       // safetySettings: ,
//       // generationConfig: ,
//     );
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void dispose(){
//     mounted.set(value: false, mounted: mounted.value);
//     textController.dispose();
//     buttons.dispose();
//     dms.dispose();
//     cleoIsLoading.dispose();
//     userInputIsLoading.dispose();
//     scrollController.dispose();
//     mounted.dispose();
//   }
//   // --------------------------------------------------------------------------
//
//   /// RESTART
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> restart() async {
//
//     final bool _reset = await Dialogs.confirmProceed(
//       headlineVerse: const Verse(id: 'phid_restart_chat_q', translate: true),
//       bodyVerse: const Verse(id: 'phid_restart_chat_warning', translate: true),
//       yesVerse: const Verse(id: 'phid_restart', translate: true),
//       noVerse: const Verse(id: 'phid_cancel', translate: true),
//     );
//
//     if (_reset == true){
//
//       await Sliders.scrollToTop(controller: scrollController);
//       _conversationID = null;
//       textController.text = '';
//       buttons.set(value: [], mounted: mounted.value);
//       cleoIsLoading.set(value: false, mounted: mounted.value);
//       userInputIsLoading.set(value: false, mounted: mounted.value);
//       _chatSession = null;
//       history = <Content>[];
//       _conversationID = Idifier.createUniqueIDString();
//       _chatSession = model?.startChat(
//         history: history,
//         // safetySettings: ,
//         // generationConfig: ,
//       );
//       dms.set(value: [], mounted: mounted.value);
//     }
//
//   }
//   // --------------------------------------------------------------------------
//
//   /// RESTART
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> onMoreTap() async {
//
//     final BuildContext context = getTheMainContext();
//
//     await BldrsBottomDialog.showButtons(
//         numberOfWidgets: 5,
//         builder: (Dimensions dims, Function setTheState){
//
//           return <Widget>[
//
//             TheWideButton(
//               text: getWord('phid_restart_chat'),
//               color: Colorz.white20,
//               verseColor: Colorz.white255,
//               borderColor: Colorz.white50,
//               onTap: () async {
//
//                 await Nav.goBack(context: context);
//
//                 await restart();
//
//               },
//             ),
//
//
//           ];
//
//         },
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// COMM
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> onSend(String? text) async {
//
//     final bool _isSignedUp = await _isSignedUpCheck();
//
//     if (_isSignedUp == true){
//
//       await CleoCommunicator.onSend(
//         mounted: mounted,
//         userInputIsLoading: userInputIsLoading,
//         cleoIsLoading: cleoIsLoading,
//         textController: textController,
//         text: text,
//         userID: OfficialAuthing.getUserID(),
//         chatSession: _chatSession,
//         dms: dms,
//         buttons: buttons,
//         conversationID: _conversationID,
//       );
//
//     }
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<bool> _isSignedUpCheck() async {
//
//     final UserModel? _user = UserPro.proGetMyUserModel();
//     bool _isSignedUp = OfficialAuthing.userIsSignedUp(_user?.signInMethod) == true;
//
//     if (_isSignedUp == false){
//       _isSignedUp = await QuickAuth.go();
//     }
//
//     return _isSignedUp;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> onButtonResponse(String? text) async {
//     buttons.set(value: [], mounted: mounted.value);
//     await onSend(text);
//   }
//   // --------------------------------------------------------------------------
//
//   /// SCROLLING
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> scrollToTop() => CleoUiController.scrollToTop(
//     scrollController: scrollController,
//   );
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> scrollToBottom() => CleoUiController.scrollToBottom(
//     scrollController: scrollController,
//   );
//   // --------------------------------------------------------------------------
//
//   /// EXPORTING
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> exportConversationLocally() => CleoLocalExporter.exportConversationLocally(
//     dms: dms.value,
//     history: history,
//     userName: UserPro.proGetMyUserModel()?.name,
//   );
//   // -----------------------------------------------------------------------------
// }
