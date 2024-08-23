import 'package:app_beto/models/user.dart';
import 'package:app_beto/private/settingScreen.dart';
import 'package:app_beto/private/telaDeSelecaoDeFilho.dart';
import 'package:app_beto/public/signinScreen.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:app_beto/widget/hexagonoPerfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../main.dart';
import '../models/filho.dart';
import '../repository/user-repository.dart';
import '../widget/bannerPrincipal.dart';
import '../widget/hexagonoFase.dart';
import '../widget/starMenuPrincipal.dart';
import '../widget/textFieldPadrao.dart';
import 'imagemDePerfil.dart';

class EditarScreen extends StatefulWidget {
  User user;
  int indexUsuario;

  EditarScreen({
    required this.user,
    required this.indexUsuario,
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<EditarScreen> createState() => _EditarScreenState();
}

class _EditarScreenState extends State<EditarScreen> {
  TextEditingController nomeController = TextEditingController();
  bool podeEnviar = false;
  late String foto;

  @override
  void initState() {
    // TODO: implement initState
    foto=  widget.user.filhos![widget.indexUsuario]!.foto!;
    nomeController.text = widget.user.filhos![widget.indexUsuario]!.nome!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorService.roxo,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: ColorService.roxo,
        title: Text(
          'Novo filho',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Filho filho = Filho(
                  // tratar pra nao pegar
                  licaoCompleta: [],
                  nome: nomeController.text,
                  foto: foto ?? '1',
                  idDoFilho: widget.indexUsuario,
                );
                // if (podeEnviar && foto != null) {
                //   await UserApi(dio)
                //       .criarNovofilho(widget.idUser, filho)
                //       .then((value) {
                //     Navigator.pop(context, filho);
                //   });
                // }

                if (podeEnviar) {
                    await UserApi(dio)
                      .editarFilho(widget.user.filhos![widget.indexUsuario]!.id!, filho)
                      .then((value) {
                    Navigator.pop(context, value);
                  });
                }
              },
              icon: Icon(
                Icons.check,
                color:
                (podeEnviar && foto != null) ? Colors.white : Colors.grey,
                size: 18,
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 67,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: ColorService.laranja,
                    radius: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: foto != null
                          ? Image.asset(getImageUrlFromIndexString(foto!))
                          : Icon(
                        Icons.photo_camera,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    foto = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImagemDePerfilScreen()));

                    podeEnviar = true;
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      backgroundColor: ColorService.laranja,
                      radius: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: TextFieldPadrao(
              onchange: (p0) {
                if (nomeController.text.isNotEmpty) {
                  setState(() {
                    podeEnviar = true;
                  });
                }
              },
              validator: Validatorless.required('Campo obrigatorio'),
              controller: nomeController,
              errorText: 'Nome do filho',
            ),
          )
        ],
      ),
    );
  }
}
