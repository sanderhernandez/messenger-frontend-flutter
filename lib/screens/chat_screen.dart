import 'dart:io';

import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  TextEditingController _textController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  bool estaEscribiendo = false;

  List<ChatMessage> _messages = [
    // ChatMessage(uuid: '123', texto: 'Hola mundo'),
    // ChatMessage(uuid: '1234', texto: 'Hola mundo'),
    // ChatMessage(uuid: '1234', texto: 'Hola mundo'),
    // ChatMessage(
    //     uuid: '123',
    //     texto:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet dictum sit amet justo donec enim diam vulputate. Enim sed faucibus turpis in eu mi. Nibh cras pulvinar mattis nunc sed blandit libero. Cras tincidunt lobortis feugiat vivamus at augue eget arcu.'),
  ];

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    // TODO: implement initState

    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket
        .on('mensaje-personal', (data) => _escucharMensaje(data));

    _cargarHistorialChat(chatService.usuarioPara.uid);

    super.initState();
  }

  Future<void> _cargarHistorialChat(String usuarioID) async {
    List<Mensaje> chat = await chatService.getChat(usuarioID);
    // print(chat);
    final history = chat.map(
      (m) => new ChatMessage(
        texto: m.mensaje,
        uuid: m.de,
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 0),
        )..forward(),
      ),
    );

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
      texto: payload['mensaje'],
      uuid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Text(usuarioPara.nombre.substring(0, 1).toUpperCase()),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              Text(
                usuarioPara.nombre,
                style: TextStyle(color: Colors.black87, fontSize: 12),
              ),
            ],
          ),
        ),
        elevation: 1,
      ),
      body: Container(
        color: Colors.white10,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) =>
                    _messages[index],
              ),
            ),
            Divider(height: 1),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (value) => _handleSubmit(value),
                onChanged: (value) {
                  // TODO:Saber cuando se está escribiendo.

                  setState(() {
                    if (value.trim().length > 0) {
                      estaEscribiendo = true;
                    } else {
                      estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isAndroid
                  ? IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          // color: Colors.blue[400],
                        ),
                        onPressed: estaEscribiendo
                            ? () => _handleSubmit(_textController.text)
                            : null,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                    )
                  : CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: estaEscribiendo
                          ? () => _handleSubmit(_textController.text)
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    // print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uuid: authService.usuario.uid,
      texto: texto,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      estaEscribiendo = false;
    });
    socketService.socket.emit('mensaje-personal', {
      'de': this.authService.usuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    // Escucha del socket = off
    socketService.socket.off('mensaje-personal');

    super.dispose();
  }
}

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}
