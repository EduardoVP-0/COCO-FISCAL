import 'package:flutter/material.dart';
import 'Estilos/diseños_capacitacion.dart';

// Importa las otras páginas necesarias
import 'Apartado_A_home.dart';
import 'ApartadoA_cursos.dart';
import 'Splash_Coco_Fiscal.dart';

class ApartadoCCF extends StatefulWidget {
  @override
  _ApartadoCCFState createState() => _ApartadoCCFState();
}

class _ApartadoCCFState extends State<ApartadoCCF> {
  int _selectedTab = 2; // Capacitación es el índice 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CapacitacionDesigns.buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 25),
            // Módulo de Tip del día
            CapacitacionDesigns.buildImageModule(
              imagePath: 'assets/images/Ana_proge.png',
              height: 190,
            ),
            SizedBox(height: 40),

            // SERVICIOS DISPONIBLES
            _buildServiciosDisponibles(),
            SizedBox(height: 40),

            // TARJETAS CON DESCRIPCIÓN - NUEVO
            _buildTarjetasDescripcion(),
          ],
        ),
      ),
      bottomNavigationBar: CapacitacionDesigns.buildBottomNavigationBar(
        currentIndex: _selectedTab,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  //PARA SERVICIOS DISPONIBLES
  Widget _buildServiciosDisponibles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Servicios disponibles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 35),

        // Fila de servicios
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTarjetaServicio(
              imagen: 'assets/images/Cursos.png',
              titulo: 'Cursos',
              onTap: () {
                // Navegar a página de cursos
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ApartadoACursos(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
            ),
            _buildTarjetaServicio(
              imagen: 'assets/images/Asesorias.png',
              titulo: 'Asesorías',
              onTap: () {},
            ),
            _buildTarjetaServicio(
              imagen: 'assets/images/ChatBot.png',
              titulo: 'ChatBot',
              onTap: () {
                // Navegar a página de chatbot
                // Navegar a página de cursos
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SplashCocoFiscal(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTarjetaServicio({
    required String imagen,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              // Contenedor de la imagen
              Container(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagen,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          color: const Color.fromARGB(255, 255, 253, 253),
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Título
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //NUEVO - TARJETAS CON DESCRIPCIÓN
  Widget _buildTarjetasDescripcion() {
    return Column(
      children: [
        // Tarjeta 1 - Alineada a la IZQUIERDA
        Align(
          alignment: Alignment.centerLeft,
          child: _buildTarjetaIzquierda(
            'Accede a videos claros y prácticos sobre temas fiscales: declaraciones, facturación, deducciones y más, explicados de forma sencilla.',
          ),
        ),
        SizedBox(height: 35),

        // Tarjeta 2 - Alineada a la DERECHA
        Align(
          alignment: Alignment.centerRight,
          child: _buildTarjetaDerecha(
            'Accede a videos claros y prácticos sobre temas fiscales: declaraciones, facturación, deducciones y más, explicados de forma sencilla.',
          ),
        ),
        SizedBox(height: 30),

        // Tarjeta 3 - Alineada a la IZQUIERDA
        Align(
          alignment: Alignment.centerLeft,
          child: _buildTarjetaIzquierda(
            'Accede a videos claros y prácticos sobre temas fiscales: declaraciones, facturación, deducciones y más, explicados de forma sencilla.',
          ),
        ),
      ],
    );
  }

  // Para tarjetas 1 y 3 (izquierda)
  Widget _buildTarjetaIzquierda(String descripcion) {
    return Container(
      width: 310,
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            // ← BORDE DERECHO GRIS MEDIO FUERTE
            color: Color.fromARGB(200, 135, 139, 146), // Gris medio fuerte
            width: 4.0,
          ),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          descripcion,
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.5),
          textAlign: TextAlign.left,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // Para tarjeta 2 (derecha)
  Widget _buildTarjetaDerecha(String descripcion) {
    return Container(
      width: 310,
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            // ← BORDE DERECHO GRIS MEDIO FUERTE
            color: Color.fromARGB(200, 135, 139, 146), // Gris medio fuerte
            width: 4.0,
          ),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          descripcion,
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.5),
          textAlign: TextAlign.left,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ApartadoAHome(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    }
  }
}
