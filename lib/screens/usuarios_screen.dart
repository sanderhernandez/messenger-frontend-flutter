import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosScreen extends StatefulWidget {
  UsuariosScreen({Key? key}) : super(key: key);

  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuariosService = new UsuariosService();

  List<Usuario> usuarios = [];

  // List<Usuario> usuarios = [
  //   Usuario(online: true, nombre: 'Felix', email: 'test1@test.com', uid: 'uid'),
  //   Usuario(
  //       online: false, nombre: 'Melissa', email: 'test2@test.com', uid: 'uid'),
  //   Usuario(
  //       online: true,
  //       nombre: 'Alexander Hernandez',
  //       email: 'test3@test.com',
  //       uid: 'uid'),
  // ];

  @override
  void initState() {
    // TODO: implement initState

    _cargarUsuarios();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            //Desconectar el socket server:
            socketService.disconnect();

            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.blue[400])
                : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue.shade400,
        ),
        child: ListView.separated(
            physics: BouncingScrollPhysics(parent: ScrollPhysics()),
            itemBuilder: (context, index) => ItemUsuario(
                  usuario: usuarios[index],
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: usuarios.length),
      ),
    );
  }

  void _cargarUsuarios() async {
    usuarios = await usuariosService.getUsuarios();

    setState(() {});

    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 3000));

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

class ItemUsuario extends StatelessWidget {
  final Usuario usuario;
  const ItemUsuario({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${usuario.nombre.substring(0, 1).toUpperCase()}'),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red[300],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        // print(usuario.nombre);

        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
