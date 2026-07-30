import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import '/views/home_view.dart';
import 'package:axi_stack/controllers/projeto_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Configurações da janela
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800), // Tamanho da tela ao abrir aplicação
    center: true, // Começa no centro do monitor
    backgroundColor: Colors
        .transparent, 
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  // Aguarda a janela ficar pronta, mostra e foca nela
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProjetoController()),
    ],

    child: const MaterialApp(
      title: 'AXI Stack',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      supportedLocales: [Locale('pt', 'BR')],
      home: HomeView(),
      ),
    ),
  );
}
