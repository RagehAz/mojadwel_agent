// ignore_for_file: require_trailing_commas
part of mojo_brain;

class MojoController {
  // --------------------------------------------------------------------------

  /// VARIABLES

  // --------------------
  String? _conversationID;
  // --------------------------------------------------------------------------

  /// AI VARIABLES

  // --------------------
  GenerativeModel? model;
  // --------------------
  ChatSession? _chatSession;
  List<Content> history = <Content>[];
  // -----------------------------------------------------------------------------

  /// INIT

  // --------------------
  /// TESTED : WORKS PERFECT
  void init(){

    _conversationID = Idifier.createUniqueIDString();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onDidChangeDependencies() async {

    // census.set(
    //   mounted: mounted.value,
    //   value: await CensusProtocols.fetchPlanetCensus(),
    // );

    final List<TextPart> _instructionParts = await CleoInitialInstructions.cleoInitialInstructions(
      // census: census.value,
    );

    model = FirebaseAI.vertexAI(
      // location: ,
      // app: ,
      // appCheck: ,
      // auth: ,
    ).generativeModel(
      model: 'gemini-2.5-flash',
      generationConfig: CleoInitialInstructions.configs,
      // safetySettings: [
      //   SafetySetting(),
      // ],
      // tools: CleoTriggers.tools,
      // toolConfig: CleoTriggers.toolConfigs,
      systemInstruction: Content('system', _instructionParts),
    );

    _chatSession = model?.startChat(
      history: history,
      // safetySettings: ,
      // generationConfig: ,
    );

  }
  // -----------------------------------------------------------------------------

  /// COMM

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onSend(String? text) async {

    final bool _isSignedUp = await _isSignedUpCheck();

    if (text != null && _isSignedUp == true){

      await MojoCommunicator.onSend(
        text: text,
        userID: 'x', // OfficialAuthing.getUserID(),
        chatSession: _chatSession,
        dms: [],
        conversationID: _conversationID,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<bool> _isSignedUpCheck() async {

    return true;
  }
  // -----------------------------------------------------------------------------
}
