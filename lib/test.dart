// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:speech_to_text/speech_to_text_provider.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   SpeechToText speechToText = SpeechToText();
//   late SpeechToTextProvider speechProvider;
//   bool speechEnabled = false;
//   final TextEditingController _controller = TextEditingController();
//   @override
//   void initState() {
//     speechProvider = SpeechToTextProvider(speechToText);
//     _initSpeech();
//     super.initState();
//   }

//   void _initSpeech() async {
//     speechEnabled = await speechToText.initialize();
//     setState(() {});
//   }

//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await speechToText.listen(onResult: _onSpeechResult);

//     setState(() {});
//   }

//   void _stopListening() async {
//     await speechToText.stop();

//     setState(() {});
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _controller.text = result.recognizedWords;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("test")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             onChanged: (value) {},
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: "search for clothes...",
//               hintStyle: Theme.of(context).textTheme.bodySmall,
//               prefixIcon: const Icon(Icons.search_outlined),
//               prefixIconColor: Theme.of(context).colorScheme.primary,
//               suffixIcon: IconButton(
//                 onPressed: speechToText.isNotListening
//                     ? _startListening
//                     : _stopListening,
//                 icon: Icon(
//                   speechToText.isNotListening
//                       ? Icons.mic
//                       : Icons.mic_external_on_sharp,
//                 ),
//               ),
//               suffixIconColor: Theme.of(context).colorScheme.primary,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).colorScheme.surface,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).colorScheme.surface,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// hi how are you today 








// import 'dart:io';

// import 'package:chatview/chatview.dart';
// import 'package:dio/dio.dart';
// import 'package:fashion/core/constant/app_links.dart';
// import 'package:fashion/core/services/crud.dart';
// import 'package:fashion/core/services/websocket_service.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'injiction_container.dart' as di;

// import 'test_model.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final WebSocketService _webSocketService = WebSocketService();
//   late final List<MessageTest> _messages = [];
//   List<Message> initMessages = [];
//   late final ChatController chatController;
//   String chatId = "user_123";
//   double upload = 1.0;
//   double download = 1.0;
//   final crud = di.sl<Crud>();
//   late String path;
//   Dio dio = Dio();
//   bool showImage = false;
//   File? file;
//   List<Message> _convertMessages(List<MessageTest> messages) {
//     return messages.map((m) => m.toMessage(path)).toList();
//   }

//   Future<void> uploadfile(String url, String filePath) async {
//     Stream<double> streamUpload = await crud.uploadFileWithStreamUpload(
//       url,
//       filePath,
//     );
//     streamUpload.listen((data) {
//       setState(() {
//         print(data);
//         upload = data;
//       });
//     });
//   }

//   Future<bool> existFile(String fileName) async {
//     final direc = await getApplicationCacheDirectory();
//     final path = "${direc.path}/$fileName";
//     final file = File(path);
//     print(file.exists());
//     return await file.exists();
//   }

//   Future<void> downloadImage(String url, String fileName) async {
//     if (await existFile(fileName)) {
//       return;
//     } else {
//       final direc = await getApplicationCacheDirectory();
//       final List<String> parts = fileName.split("/");
//       final namefolder = parts[0];
//       final nameImage = parts[1];
//       final dir = Directory("${direc.path}/$namefolder");
//       await dir.create(recursive: true);
//       final path = "${direc.path}/$namefolder";
//       // await FlutterDownloader.enqueue(
//       //   url: '${AppLinks.chatImages}$nameImage',
//       //   // headers: {}, // optional: header send with url (auth token etc)
//       //   savedDir: path,
//       //   showNotification:
//       //       false, // show download progress in status bar (for Android)
//       //   openFileFromNotification:
//       //       false, // click on notification to open downloaded file (for Android)
//       // );
//     }
//   }

//   Future<void> downloadVoice(String url, String fileName) async {
//     if (await existFile(fileName)) {
//       return;
//     } else {
//       final direc = await getApplicationCacheDirectory();
//       final path = direc.path;
//       // await FlutterDownloader.enqueue(
//       //   url: '${AppLinks.chatVoices}$fileName',
//       //   // headers: {}, // optional: header send with url (auth token etc)
//       //   savedDir: path,
//       //   showNotification:
//       //       false, // show download progress in status bar (for Android)
//       //   openFileFromNotification:
//       //       false, // click on notification to open downloaded file (for Android)
//       // );
//       // FlutterDownloader.registerCallback((taskId, _, progress) {});
//     }
//   }

//   @override
//   void initState() {
//     sourcefile();
//     _initWebSocket();
//     chatController = ChatController(
//       initialMessageList: _convertMessages(_messages),
//       scrollController: ScrollController(),
//       currentUser: const ChatUser(id: 'server_1', name: 'simfrom'),
//       otherUsers: const [ChatUser(id: 'user_123', name: 'flutter')],
//     );
//     super.initState();
//   }

//   void _initWebSocket() {
//     // 1. الاتصال بالخادم
//     _webSocketService.connect(
//       'ws://192.168.1.6:8080/duraykish_market/server_chat.php',
//     );

//     // 2. الانضمام للدردشة
//     _webSocketService.joinChat(chatId);
//     _webSocketService.messageStream.listen((data) {
//       _handleIncomingMessage(data);
//     });
//   }

//   void _handleIncomingMessage(Map<String, dynamic> data) {
//     switch (data['action']) {
//       case 'message_history':
//         // معالجة الرسائل التاريخية
//         final List<dynamic> messagesJson = data['messages'];
//         // print(messagesJson);
//         setState(() {
//           _messages.clear();
//           _messages.addAll(
//             messagesJson.map((json) {
//               if (json['type'] == "audio") {
//                 downloadVoice(
//                   "${AppLinks.chatVoices}${json['message']}",
//                   "${json['message']}",
//                 );
//               } else if (json['type'] == "image") {
//                 downloadImage(
//                   "${AppLinks.chatImages}${json['message']}",
//                   "${json['message']}",
//                 );
//               }
//               return MessageTest.fromJson(json);
//             }),
//           );
//           initMessages = _convertMessages(_messages);
//           chatController.initialMessageList = initMessages;
//         });
//         break;

//       case 'new_message':
//         // معالجة رسالة جديدة
//         setState(() async {
//           // print(data);
//           if (data["sender_id"] != "server_1") {
//             if (data['type'] == "audio") {
//               await downloadVoice(
//                 "${AppLinks.chatVoices}${data['message']}",
//                 "${data['message']}",
//               );
//             } else if (data['type'] == "image") {
//               await downloadImage(
//                 "${AppLinks.chatImages}${data['message']}",
//                 "${data['message']}",
//               );
//             }
//             _messages.add(MessageTest.fromJson(data));
//             final oneMessage = MessageTest.fromJson(data);
//             final messageone = oneMessage.toMessage(path);
//             chatController.addMessage(messageone);
//           }
//         });
//         break;

//       // case 'user_joined':
//       //   // إشعار انضمام مستخدم
//       //   _showUserJoinedNotification(data['user_id']);
//       //   break;

//       // case 'user_left':
//       //   // إشعار مغادرة مستخدم
//       //   _showUserLeftNotification(data['user_id']);
//       //   break;
//     }
//   }

//   void _sendMessage(String text, String messagetype) {
//     if (text.isEmpty) return;
//     _webSocketService.sendTextMessage(
//       chatId,
//       text,
//       "server_1",
//       messagetype,
//       "user_123", // يجب استبداله بآلية مصادقة
//     );

//     // _messageController.clear();
//   }

//   Future<void> sourcefile() async {
//     final dir = await getApplicationCacheDirectory();
//     path = dir.path;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('الدردشة: $chatId'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () {
//               _webSocketService.leaveChat(chatId);
//               Navigator.pop(context);
//             },
//           ),
//           if (upload != 1) Text("${(upload * 100).toStringAsFixed(1)} %"),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 try {
//                   final response = await dio.download(
//                     "${AppLinks.chatImages}Screenshot_٢٠٢٥٠٩١٥-١٢٠٨٠٧_Facebook.jpg",
//                     '${(await getApplicationCacheDirectory()).path}/Screenshot_٢٠٢٥٠٩١٥-١٢٠٨٠٧_Facebook.jpg',
//                   );
//                   file = File(
//                     "${(await getApplicationCacheDirectory()).path}/Screenshot_٢٠٢٥٠٩١٥-١٢٠٨٠٧_Facebook.jpg",
//                   );
//                   // print((await getApplicationCacheDirectory()).path);
//                   print(file!.path);
//                   print(response.data);
//                   print(response.extra);
//                   print(response.statusCode);
//                   // print(response.)
//                   print(response.requestOptions.onReceiveProgress);
//                   if (response.statusCode == 200) {
//                     setState(() {
//                       showImage = true;
//                     });
//                   }
//                 } catch (e) {
//                   print(e);
//                   showImage = false;
//                 }
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 color: Colors.blue,
//                 child: Text("Download"),
//               ),
//             ),
//             if (showImage) Expanded(child: Image.file(file!)),
//           ],
//         ),
//       ),
//       //  ChatView(
//       //   onSendTap: (message, replyMessage, messageType) async {
//       //     // print(message);
//       //     // final directory = await getApplicationCacheDirectory();
//       //     // print(directory);

//       //     if (messageType.isVoice) {
//       //       final audioName = basename(message);
//       //       _sendMessage(audioName, "audio");
//       //       final insertMessage = Message(
//       //         message: message,
//       //         createdAt: DateTime.now(),
//       //         sentBy: "server_1",
//       //         messageType: MessageType.voice,
//       //       );
//       //       chatController.addMessage(insertMessage);
//       //       uploadfile(AppLinks.uploadVoice, message);
//       //     } else if (messageType.isImage) {
//       //       final direc = await getApplicationCacheDirectory();
//       //       final endPath = message.replaceAll("${direc.path}/", "");
//       //       _sendMessage(endPath, "image");
//       //       final insertMessage = Message(
//       //         message: message,
//       //         createdAt: DateTime.now(),
//       //         sentBy: "server_1",
//       //         messageType: MessageType.image,
//       //       );
//       //       chatController.addMessage(insertMessage);
//       //       uploadfile(AppLinks.uploadImage, message);
//       //     } else {
//       //       _sendMessage(message, "text");
//       //       final insertMessage = Message(
//       //         message: message,
//       //         createdAt: DateTime.now(),
//       //         sentBy: "server_1",
//       //       );
//       //       chatController.addMessage(insertMessage);
//       //     }
//       //   },
//       //   messageConfig: MessageConfiguration(
//       //     imageMessageConfig: ImageMessageConfiguration(hideShareIcon: true),
//       //     voiceMessageConfig: VoiceMessageConfiguration(
//       //       playerWaveStyle: PlayerWaveStyle(),
//       //     ),
//       //   ),
//       //   chatBackgroundConfig: ChatBackgroundConfiguration(
//       //     backgroundColor: Colors.black38,
//       //   ),
//       //   sendMessageConfig: SendMessageConfiguration(
//       //     enableCameraImagePicker: false,
//       //     textFieldConfig: TextFieldConfiguration(
//       //       textStyle: TextStyle(color: Colors.black),
//       //     ),
//       //   ),

//       //   chatController: chatController,
//       //   chatViewState: _messages.isEmpty
//       //       ? ChatViewState.loading
//       //       : ChatViewState.hasMessages,
//       // ),
//     );
//   }

//   @override
//   void dispose() {
//     _webSocketService.leaveChat(chatId);
//     _webSocketService.disconnect();
//     chatController.dispose();
//     super.dispose();
//   }
// }

// extension MessageConversion on MessageTest {
//   Message toMessage(String path) {
//     return type == "audio"
//         ? Message(
//             id: id.toString(),
//             message: "$path/$message",
//             createdAt: timestamp,
//             sentBy: senderId,
//             messageType: MessageType.voice,
//             status: MessageStatus.read,
//           )
//         : type == "image"
//         ? Message(
//             id: id.toString(),
//             message: "$path/$message",
//             createdAt: timestamp,
//             sentBy: senderId,
//             messageType: MessageType.image,
//             status: MessageStatus.read,
//           )
//         : Message(
//             id: id.toString(),
//             message: message,
//             createdAt: timestamp,
//             sentBy: senderId,
//             status: MessageStatus.read,
//           );
//   }
// }



 // a5d943f3-62c7-4ebe-a4f8-6b39be120cf8/Screenshot_٢٠٢٥٠٩٠٨-٠٧١٠٤٩_YouTube.jpg
 // 9e58661b-48dd-4324-8501-0f7437963ab2/Screenshot_٢٠٢٥٠٩٠٨-٠٧١٠٤٩_YouTube.jpg
 // 64762242-5ba2-4632-ae49-0f0af41d5bc4/Screenshot_٢٠٢٥٠٩٠٨-٠٧١٠٤٩_YouTube.jpg



















// Chat(
//         decoration: BoxDecoration(),
//         chatController: chatController,
//         builders: Builders(),
//         onAttachmentTap: () {},

//         onMessageSend: (text) {
//           print(text);
//           _sendMessage(text);

//           // chatController.insertMessage(
//           //   TextMessage(
//           //     // Better to use UUID or similar for the ID - IDs must be unique
//           //     id: '${Random().nextInt(1000) + 1}',
//           //     authorId: '2',
//           //     createdAt: DateTime.now().toUtc(),
//           //     text: text,
//           //   ),
//           // );
//         },
//         currentUserId: chatId,
//         resolveUser: (UserID id) async {
//           return User(id: "server_1", name: 'John Doe');
//         },
//       ),
// Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.inversePrimary,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     _messages[index].message,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: 'اكتب رسالتك...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),



// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   final TextEditingController textController = TextEditingController();
//   List<Message> messages = [
//     TextMessage(
//       id: "1",
//       authorId: "2",
//       text: "hllow",
//       createdAt: DateTime.now(),
//     ),
//   ];
//   late InMemoryChatController chatController = InMemoryChatController();
//   // ChatController chatControllerr = ChatController()
//   bool textEmpty = true;
//   @override
//   void initState() {
//     chatController;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     chatController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Customer Service"), centerTitle: true),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         color: Theme.of(context).colorScheme.secondaryContainer,
//         child: BlocBuilder<CustomerServiceBloc, CustomerServiceState>(
//           builder: (context, state) {
//             return Chat(
//               decoration: BoxDecoration(),
//               chatController: chatController,
//               builders: Builders(),
//               onAttachmentTap: () {},

//               onMessageSend: (text) {
//                 // List<Message> messag= state.
//                 chatController.insertAllMessages(state.chatMessage);
//                 // chatController.insertMessage(
//                 //   TextMessage(
//                 //     // Better to use UUID or similar for the ID - IDs must be unique
//                 //     id: '${Random().nextInt(1000) + 1}',
//                 //     authorId: '2',
//                 //     createdAt: DateTime.now().toUtc(),
//                 //     text: text,
//                 //   ),
//                 // );
//               },
//               currentUserId: "ek",
//               resolveUser: (UserID id) async {
//                 return User(id: id, name: 'John Doe');
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

  // void _onSendPressed(types.PartialText message) {
  //   final textMessage = types.TextMessage(
  //     author: types.User(id: "1"),
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     id: "id",
  //     text: message.text,
  //   );
  //   _addMessage(textMessage);
  // }

  // void _addMessage(types.Message textMessage) {
  //   setState(() {
  //     messages.insert(0, textMessage);
  //   });
  // }
// }

// body: BlocListener<AddLocationBloc, AddLocationState>(
//   listener: (context, state) {
//     if (state.errorMessage.isNotEmpty) {
//       showSnacBarFun(context, state.errorMessage, Colors.redAccent);
//     }
//   },
//   child: Container(
//     color: Theme.of(context).colorScheme.secondaryContainer,
//     padding: const EdgeInsets.only(top: 20),
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height,
//     child: SafeArea(
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               BlocBuilder<AddLocationBloc, AddLocationState>(
//                 builder: (context, state) {
//                   return Expanded(
//                       child: SizedBox(
//                     child: FlutterMap(
//                       mapController: map,
//                       options: MapOptions(
//                         // cameraConstraint: mera.center,
//                         onTap: (tapposition, latLng) {
//                           // print(tapposition.global);
//                           // print("${latLng.latitude}");
//                           // print("${latLng.longitude}");
//                           context
//                               .read<AddLocationBloc>()
//                               .add(AddMarkerEvent(
//                                 latLng.latitude,
//                                 latLng.longitude,
//                               ));
//                         },
//                         initialCenter: const LatLng(34.88921888689081,
//                             36.14061178731744), // Center the map over London
//                         initialZoom: 13,
//                       ),
//                       children: [
//                         TileLayer(
//                           urlTemplate:
//                               'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
//                           userAgentPackageName:
//                               'com.example.fashion', // Add your app identifier
//                           // And many more recommended properties!
//                         ),
//                         MarkerLayer(markers: state.markers),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: GestureDetector(
//                               onTap: () {
//                                 context
//                                     .read<AddLocationBloc>()
//                                     .add(const GetMyLocationEvent());
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.all(30),
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .secondaryContainer
//                                       .withOpacity(0.6),
//                                   borderRadius: BorderRadius.circular(60),
//                                   border: Border.all(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .inversePrimary),
//                                 ),
//                                 child: const Center(
//                                   child: Icon(Icons.my_location),
//                                 ),
//                               )),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: GestureDetector(
//                               onTap: () {
//                                 context.read<AddLocationBloc>().add(
//                                     const AddNewLocationEvent(
//                                         LocationEntity(
//                                             addressName: "",
//                                             fullAddress: "",
//                                             latitude: 0.0,
//                                             longitude: 0.0,
//                                             locationID: 0,
//                                             userID: 0,
//                                             defultAddress: 0)));
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.all(30),
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .secondaryContainer
//                                       .withOpacity(0.6),
//                                   borderRadius: BorderRadius.circular(60),
//                                   border: Border.all(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .inversePrimary),
//                                 ),
//                                 child: const Center(
//                                   child: Icon(Icons.add),
//                                 ),
//                               )),
//                         ),
//                       ],
//                     ),
//                   ));
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ),
// ),

//  RichAttributionWidget(

//   // Include a stylish prebuilt attribution widget that meets all requirments
//   attributions: [
//     TextSourceAttribution(
//       'OpenStreetMap contributors',
//       // onTap: (){
//       //   Marker(point: LatLng(, longitude), child: child)
//       // } //(external)
//     ),
//     // Also add images...
//   ],
// ),

// Container(
//         child: Column(
//           children: [
//             Stepper(
//               // connectorColor: WidgetStatePropertyAll(Colors.black),
//               stepIconBuilder: (i, state) {
//                 return i <= currentStep
//                     ? Icon(Icons.radio_button_checked)
//                     : Icon(
//                         Icons.radio_button_off_outlined,
//                         color: Colors.grey,
//                       );
//               },
//               connectorThickness: 2,
//               stepIconMargin: EdgeInsets.all(0),
//               controlsBuilder: (context, details) {
//                 return Container();
//               },
//               currentStep: currentStep,
//               steps: <Step>[
//                 Step(
//                   title: Text("Packing"),
//                   content: SizedBox(),
//                   stepStyle: StepStyle(
//                     color: Colors.white,
//                   ),
//                   isActive: currentStep >= 0 ? true : false,
//                   state: currentStep >= 0
//                       ? StepState.complete
//                       : StepState.disabled,
//                 ),
//                 Step(
//                   title: Text("packed"),
//                   content: SizedBox(),
//                   isActive: currentStep >= 1 ? true : false,
//                   state: currentStep >= 1
//                       ? StepState.complete
//                       : StepState.disabled,
//                   stepStyle: StepStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Step(
//                   title: Text("In Transit"),
//                   content: SizedBox(),
//                   isActive: currentStep >= 2 ? true : false,
//                   state: currentStep >= 2
//                       ? StepState.complete
//                       : StepState.disabled,
//                   stepStyle: StepStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Step(
//                   subtitle: Icon(Icons.my_location),
//                   title: Text("Delivered"),
//                   content: SizedBox(),
//                   isActive: currentStep >= 3 ? true : false,
//                   state: currentStep >= 3
//                       ? StepState.complete
//                       : StepState.disabled,
//                   stepStyle: StepStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
