import 'package:app_beto/main.dart';
import 'package:app_beto/private/homePage.dart';
import 'package:app_beto/private/novoFIlhoScreen.dart';
import 'package:app_beto/repository/licao-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../changeNotifier/auth.dart';
import '../models/filho.dart';
import '../models/user.dart';
import '../repository/user-repository.dart';
import '../shared/service/stroreService.dart';

class SelecaoDeFilhoScreen extends StatefulWidget {
  User user;
  SelecaoDeFilhoScreen({required this.user});

  @override
  State<SelecaoDeFilhoScreen> createState() => _SelecaoDeFilhoScreenState();
}

class _SelecaoDeFilhoScreenState extends State<SelecaoDeFilhoScreen> {
  bool semaforo = false;

  List<Filho?>? filhos = [];
  List<bool> selecionados = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    if (!semaforo) {
      filhos = widget.user.filhos;
      setState(() {
        semaforo = true;
      });
    }
    Auth auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorService.roxo,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorService.roxo,
        title: Text(
          'App Beto',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: Center(
                  child: Text(
                'Quem vai jogar ?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              )),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 41,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 35,
              children: List.generate(filhos!.length + 1, (index) {
                if (index == filhos!.length) {
                  return InkWell(
                    onTap: () async {
                      Filho? novoFilho = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NovoFilhoScreen(
                                  index: filhos!.length,
                                  idUser: widget.user.id!)));
                      if (novoFilho != null) {
                        filhos!.add(novoFilho);
        
                        setState(() {});
                      }
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 67,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: ColorService.laranja,
                            radius: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Adicionar filho',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () async {
                      User user = await UserApi(dio).getUser(auth.getUserId());
                      await Store.save("user", user);
                      await Store.save("indexFilho", index);
        
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyHomePage()));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: selecionados[index] ? 72 : 67,
                          backgroundColor: selecionados[index]
                              ? ColorService.laranja
                              : Colors.white,
                          child: CircleAvatar(
                            radius: selecionados[index] ? 70 : 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset(getImageUrlFromIndexString(
                                  filhos![index]!.foto!)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            filhos![index]!.nome!,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
