import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PerfilPage(),
    );
  }
}

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  final ImagePicker picker = ImagePicker();

  Uint8List? fotoPerfil;

  Future<void> escolherDaGaleria() async {
    final XFile? imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem == null) {
      return;
    }

    final bytes = await imagem.readAsBytes();

    if (!mounted) {
      return;
    }

    setState(() {
      fotoPerfil = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil"),
      ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      CircleAvatar(
        radius: 60,
        backgroundImage:
        fotoPerfil != null ? MemoryImage(fotoPerfil!) : null,
        child: fotoPerfil == null? const Icon(Icons.person, size: 70): null,
      ),

      const SizedBox(height: 20,),

      const Text(
        'Isabella Leite',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
      ),

      const SizedBox(height: 8,),

      const Text(
        'isaLt@gmail.com'
      ),
      
      const SizedBox(height: 10,),

      ElevatedButton.icon(
        onPressed: escolherDaGaleria,
        icon: const Icon(Icons.camera_alt),
        label: const Text("Alterar Foto"),
        )


      ]
    ),
    )
    );
  }
}
