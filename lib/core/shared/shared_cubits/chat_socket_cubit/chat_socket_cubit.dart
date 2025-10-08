import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingora/core/utils/services/local_services/cache_keys.dart';
import 'package:pingora/core/utils/services/remote_services/endpoints.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_socket_state.dart';

class ChatSocketCubit extends Cubit<ChatSocketState> {
  ChatSocketCubit() : super(ChatSocketInitial());

  Uri? wsUrl;
  WebSocketChannel? channel;

  initSocket() {
    try {
      // Get the bearer token from cache
      String bearerToken = CacheKeysManger.getAccessToken();

      // Parse the socket URL
      wsUrl = Uri.parse(EndPoints.socketUrl);

      if (bearerToken.isNotEmpty) {
        log(
          'Socket connecting with bearer token: ${bearerToken.substring(0, 10)}...',
        );

        // Create WebSocket with headers using IOWebSocketChannel
        channel = IOWebSocketChannel.connect(
          wsUrl!,
          headers: {
            'authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json',
          },
        );
      } else {
        log('Warning: No bearer token found for socket connection');
        // Connect without headers
        channel = WebSocketChannel.connect(wsUrl!);
      }

      log('Socket connection established with authentication');
    } catch (e) {
      log('Error initializing socket: $e');
    }
  }

  /// Generic function to listen to any socket event
  /// This function will listen to incoming data from the socket
  /// and call the provided callback function with the received data
  void listenToSocketEvent({
    required Function(dynamic data) onSuccess,
    Function(dynamic error)? onError,
  }) {
    try {
      if (channel == null) {
        log('Socket channel is not initialized. Call initSocket() first.');
        return;
      }

      // Listen to the socket stream
      channel!.stream.listen(
        (data) {
          log('Socket received data: $data');
          // Call the callback function with received data
          onSuccess(data);
        },
        onError: (error) {
          log('Socket listen error: $error');
          if (onError != null) {
            onError(error);
          }
        },
        onDone: () {
          log('Socket connection closed');
        },
      );
    } catch (e) {
      log('Error setting up socket listener: $e');
      if (onError != null) {
        onError(e);
      }
    }
  }

  /// Generic function to emit data to the socket
  /// This function can send any type of data to the socket
  /// data can be String, Map, List, or any serializable object
  void emitToSocket({
    required dynamic data,
    Function()? onSuccess,
    Function(dynamic error)? onError,
  }) {
    try {
      if (channel == null) {
        log('Socket channel is not initialized. Call initSocket() first.');
        if (onError != null) {
          onError('Socket not initialized');
        }
        return;
      }

      // Convert data to string if it's not already

      // Send data through the socket
      channel!.sink.add(jsonEncode(data));
      log('Socket sent data: $data');

      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      log('Error sending data to socket: $e');
      if (onError != null) {
        onError(e);
      }
    }
  }

  /// Close the socket connection
  void closeSocket() {
    try {
      channel?.sink.close();
      log('Socket connection closed');
    } catch (e) {
      log('Error closing socket: $e');
    }
  }

  @override
  Future<void> close() {
    closeSocket();
    return super.close();
  }
}
