import 'package:app_beto/main.dart';
import 'package:app_beto/models/filho.dart';
import 'package:app_beto/private/imagemDePerfil.dart';
import 'package:app_beto/repository/user-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../widget/textFieldPadrao.dart';

class NovoFilhoScreen extends StatefulWidget {
  int index;
  String idUser;
  NovoFilhoScreen({required this.index, required this.idUser});

  @override
  State<NovoFilhoScreen> createState() => _NovoFilhoScreenState();
}

class _NovoFilhoScreenState extends State<NovoFilhoScreen> {
  TextEditingController nomeController = TextEditingController();
  bool podeEnviar = false;
  String? foto;
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
                  licaoCompleta: [],
                  nome: nomeController.text,
                  foto: foto ?? '1',
                  idDoFilho: widget.index,
                );
                if (podeEnviar && foto != null) {
                  await UserApi(dio)
                      .criarNovofilho(widget.idUser, filho)
                      .then((value) {
                    Navigator.pop(context, filho);
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
