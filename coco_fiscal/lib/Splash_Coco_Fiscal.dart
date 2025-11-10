import 'package:flutter/material.dart';

class SplashCocoFiscal extends StatefulWidget {
  const SplashCocoFiscal({Key? key}) : super(key: key);

  @override
  State<SplashCocoFiscal> createState() => _SplashCocoFiscalState();
}

class _SplashCocoFiscalState extends State<SplashCocoFiscal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.8,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Fondo verde claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen con efecto de palpitación
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      //shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Icono.png',
                        ), // Reemplaza con tu imagen
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            // Título centrado
            const Text(
              '! H O L A !',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Descripción de dos líneas
            const Column(
              children: [
                Text(
                  'Mi nombre es Cocó y',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  'estoy aquí para ayudarte',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Botón
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50), // Verde
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Pregúntale a Cocó',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
