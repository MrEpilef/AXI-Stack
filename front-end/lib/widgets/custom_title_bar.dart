import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 45,
        color: const Color.fromARGB(255, 0, 27, 41),
        child: Row(
          children: [
            const SizedBox(width: 15),
            const Text(
              'Gestor Softtec',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Spacer(),
            // Botões da janela (Minimizar, Maximizar, Fechar)
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.minimize,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () => windowManager.minimize(),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.crop_square,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () async {
                    if (await windowManager.isMaximized()) {
                      windowManager.unmaximize();
                    } else {
                      windowManager.maximize();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 15),
                  hoverColor: Colors.red,
                  onPressed: () => windowManager.close(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
