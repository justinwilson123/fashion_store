import 'package:chatview/chatview.dart';
import 'package:fashion/feature/account/presentation/controller/customser_service_websocket/customer_service_websocket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomerServicePage extends StatelessWidget {
  const CustomerServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: const Text("Customer Service"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            context.read<CustomerServiceWebsocketBloc>().add(
              LeaveChatDisconnectEvent(),
            );
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () async {},
              icon: const Icon(Icons.phone_outlined),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          context.read<CustomerServiceWebsocketBloc>().add(
            LeaveChatDisconnectEvent(),
          );
          return true;
        },
        child:
            BlocBuilder<
              CustomerServiceWebsocketBloc,
              CustomerServiceWebsocketState
            >(
              builder: (context, state) {
                return SafeArea(
                  child: !state.isInit
                      ? Center(child: CircularProgressIndicator())
                      : ChatView(
                          chatController:
                              CustomerServiceWebsocketBloc.chatController,
                          chatViewState: state.chatViewState,
                          onSendTap: (text, replyMessage, messageType) {
                            if (messageType.isImage) {
                              context.read<CustomerServiceWebsocketBloc>().add(
                                SendMessageEvent(text, "image", messageType),
                              );
                            } else if (messageType.isVoice) {
                              context.read<CustomerServiceWebsocketBloc>().add(
                                SendMessageEvent(text, "audio", messageType),
                              );
                            } else {
                              context.read<CustomerServiceWebsocketBloc>().add(
                                SendMessageEvent(text, "text", messageType),
                              );
                            }
                          },
                          chatBackgroundConfig: ChatBackgroundConfiguration(
                            sortEnable: true,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                          ),
                          chatBubbleConfig: ChatBubbleConfiguration(
                            outgoingChatBubbleConfig: ChatBubble(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              textStyle: Theme.of(
                                context,
                              ).textTheme.headlineLarge,
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                            inComingChatBubbleConfig: ChatBubble(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),

                          sendMessageConfig: SendMessageConfiguration(
                            voiceRecordingConfiguration:
                                VoiceRecordingConfiguration(
                                  // waveStyle: WaveStyle()
                                ),
                            micIconColor: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                            imagePickerIconsConfig:
                                ImagePickerIconsConfiguration(
                                  galleryIconColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                            defaultSendButtonColor: Theme.of(
                              context,
                            ).colorScheme.inversePrimary,
                            enableCameraImagePicker: false,
                            textFieldConfig: TextFieldConfiguration(
                              textStyle: TextStyle(color: Colors.black),
                            ),
                          ),

                          messageConfig: MessageConfiguration(
                            voiceMessageConfig: VoiceMessageConfiguration(
                              playerWaveStyle: PlayerWaveStyle(
                                fixedWaveColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                liveWaveColor: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                              ),
                              pauseIcon: Icon(
                                Icons.pause,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                              ),
                              playIcon: Icon(
                                Icons.play_circle_outlined,
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                              ),
                            ),
                            imageMessageConfig: ImageMessageConfiguration(
                              hideShareIcon: true,
                            ),
                          ),
                        ),
                );
              },
            ),
      ),
    );
  }
}

// import 'package:just_audio/just_audio.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:fashion/core/class/record_voice.dart';
// import 'package:fashion/feature/account/presentation/controller/customer_service/customer_service_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../injiction_container.dart' as di;

// class CustomerServicePage extends StatelessWidget {
//   CustomerServicePage({super.key});
//   final TextEditingController text = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//         title: const Text("Customer Service"),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () async {
//             // await di.sl<RecordVoice>().disposeRecord();
//             // if (!context.mounted) return;
//             context.pop();
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: IconButton(
//               onPressed: () async {},
//               icon: const Icon(Icons.phone_outlined),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
//         color: Theme.of(context).colorScheme.secondaryContainer,
        // child: Column(
        //   children: [
        //     Divider(color: Theme.of(context).colorScheme.surface),
        //     Expanded(
        //       child: BlocBuilder<CustomerServiceBloc, CustomerServiceState>(
        //         builder: (context, state) {
        //           return Directionality(
        //             textDirection: TextDirection.ltr,
        //             child: DashChat(
        //               messageListOptions: const MessageListOptions(
        //                 separatorFrequency: SeparatorFrequency.hours,
        //               ),
        //               messageOptions: MessageOptions(
        //                 messageMediaBuilder: (message, _, __) {
        //                   return message.medias!.first.type == MediaType.voice
        //                       ? Container(
        //                           padding: EdgeInsets.all(5),
        //                           decoration: BoxDecoration(
        //                             color: Theme.of(context)
        //                                 .colorScheme
        //                                 .inversePrimary,
        //                             borderRadius: BorderRadius.circular(10),
        //                           ),
        //                           child: ClipOval(
        //                             child: Container(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .secondaryContainer,
        //                               height: 35,
        //                               width: 35,
        //                               child: IconButton(
        //                                 onPressed: () async {
        //                                   await audioPlayer.setAudioSource(
        //                                     preload: false,
        //                                     AudioSource.uri(
        //                                       Uri.parse(
        //                                           message.medias!.first.url),
        //                                     ),
        //                                   );
        //                                   print(message.medias!.first.url);
        //                                   if (audioPlayer.playing ||
        //                                       audioPlayer.processingState ==
        //                                           ProcessingState.completed) {
        //                                     await audioPlayer.stop();
        //                                   } else {
        //                                     await audioPlayer.play();
        //                                   }
        //                                 },
        //                                 // http://192.168.1.5/duraykish_market/upload/messages/voices/1_recording_1755788204155.wav

        //                                 icon:
        //                                     Icon(Icons.play_arrow, size: 18),
        //                               ),
        //                             ),
        //                           ),
        //                         )
        //                       : Container();
        //                 },
        //                 showOtherUsersAvatar: false,
        //                 showTime: true,
        //                 currentUserContainerColor:
        //                     Theme.of(context).colorScheme.inversePrimary,
        //               ),
        //               inputOptions: InputOptions(
        //                 alwaysShowSend: true,
        //                 sendButtonBuilder: (send) {
        //                   return text.text == ""
        //                       ? GestureDetector(
        //                           onTapDown: (_) {
        //                             context
        //                                 .read<CustomerServiceBloc>()
        //                                 .add(const IsRecordEvent(true));
        //                             context
        //                                 .read<CustomerServiceBloc>()
        //                                 .add(const StartRecordVoiceEvent());
        //                           },
        //                           onTapUp: (_) {
        //                             context
        //                                 .read<CustomerServiceBloc>()
        //                                 .add(const IsRecordEvent(false));
        //                             context
        //                                 .read<CustomerServiceBloc>()
        //                                 .add(const StopRecordVoiceEvent());
        //                           },
        //                           child: Container(
        //                             padding: const EdgeInsets.all(10),
        //                             margin: const EdgeInsets.symmetric(
        //                                 horizontal: 10),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(10),
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .inversePrimary,
        //                             ),
        //                             child: BlocSelector<CustomerServiceBloc,
        //                                 CustomerServiceState, bool>(
        //                               selector: (state) => state.isRecord,
        //                               builder: (context, isRecord) {
        //                                 return Icon(
        //                                   isRecord
        //                                       ? Icons.pause
        //                                       : Icons.mic_none,
        //                                   color: Theme.of(context)
        //                                       .colorScheme
        //                                       .secondaryContainer,
        //                                 );
        //                               },
        //                             ),
        //                           ),
        //                         )
        //                       : GestureDetector(
        //                           onTap: send,
        //                           child: const Padding(
        //                             padding:
        //                                 EdgeInsets.symmetric(horizontal: 10),
        //                             child: Icon(Icons.send),
        //                           ));
        //                 },
        //                 textController: text,
        //                 inputDecoration: InputDecoration(
        //                   suffixIcon: Icon(
        //                     Icons.photo_outlined,
        //                     color: Theme.of(context).colorScheme.primary,
        //                   ),
        //                   // icon: ,
        //                   hintText: "write your message...",
        //                   focusedBorder: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(10),
        //                     borderSide: BorderSide(
        //                         color: Theme.of(context).colorScheme.surface),
        //                   ),
        //                   enabledBorder: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(10),
        //                     borderSide: BorderSide(
        //                         color: Theme.of(context).colorScheme.surface),
        //                   ),
        //                 ),
        //               ),
        //               currentUser: ChatUser(id: state.userID.toString()),
        //               onSend: (message) {
        //                 text.text == ""
        //                     ? null
        //                     : context
        //                         .read<CustomerServiceBloc>()
        //                         .add(SendMessageEvent(message));
        //               },
        //               messages: state.chatMessage,
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
//       ),
//     );
//   }
// }
