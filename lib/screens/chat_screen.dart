import 'dart:io';

import 'package:chat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Text('M'),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              Text(
                'Melissa',
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
      uuid: '123',
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
  }

  @override
  void dispose() {
    // TODO: Escuchar del socket = off

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

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
