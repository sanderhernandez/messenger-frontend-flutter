import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosScreen extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  UsuariosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Usuario> usuarios = [
      Usuario(
          online: true, nombre: 'Felix', email: 'test1@test.com', uid: 'uid'),
      Usuario(
          online: false,
          nombre: 'Melissa',
          email: 'test2@test.com',
          uid: 'uid'),
      Usuario(
          online: true,
          nombre: 'Alexander Hernandez',
          email: 'test3@test.com',
          uid: 'uid'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nombre',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app_outlined,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle),
            color: Colors.blue[400],
            onPressed: () {},
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
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
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
    );
  }
}
