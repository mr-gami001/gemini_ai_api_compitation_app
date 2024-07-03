import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../utils/constants.dart';
import 'message_dm.dart';

class ChatBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  List<MessageDm> chatList;

  ChatBloc(this.chatList) : super(InitState()) {
    on<InitEvent>(_mapInitEventState);
    on<SendToAIEvent>(_mapSendToAIEventState);
  }

  FutureOr _mapInitEventState(InitEvent event, Emitter<ChatBlocState> emit) {
    chatList = [];
    emit(SucessState([]));
  }

  Future<FutureOr> _mapSendToAIEventState(
      SendToAIEvent event, Emitter<ChatBlocState> emit) async {
    try {
      chatList.add(MessageDm(
          SenderType.user, event.question, DateTime.now().toString()));
      emit(SucessState(chatList.reversed.toList()));
      var response = await Constants.model.generateContent(
        [
          Content.text(event.question),
        ],
      );
      Constants.sucessLog(response.text);
      chatList.add(
          MessageDm(SenderType.ai, response.text, DateTime.now().toString()));
      emit(SucessState(chatList.reversed.toList()));
    } catch (e) {
      Constants.errorLog(e);
    }
  }
}

abstract class ChatBlocState {}

class InitState extends ChatBlocState {}

abstract class ChatBlocEvent {}

class InitEvent extends ChatBlocEvent {}

class SendToAIEvent extends ChatBlocEvent {
  String question;

  SendToAIEvent(this.question);
}

class SucessState extends ChatBlocState {
  List<MessageDm> chatList;

  SucessState(this.chatList);
}
