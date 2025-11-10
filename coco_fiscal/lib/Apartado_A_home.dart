import 'package:flutter/material.dart';
import 'dart:async';
import 'Estilos/diseños_home.dart';

// Navegación a otras pantallas
import 'form_crear_cfdi.dart';
import 'Apartado_C_CF.dart';
import 'Noticias_Recomendada_cate1.dart';

// Modelo para las noticias
class NoticiaModel {
  final String titulo;
  final String imagen;

  NoticiaModel({required this.titulo, required this.imagen});
}

class ApartadoAHome extends StatefulWidget {
  @override
  _ApartadoAHomeState createState() => _ApartadoAHomeState();
}

class _ApartadoAHomeState extends State<ApartadoAHome> {
  int _currentIndex = 0;
  int _selectedTab = 0;
  final List<String> _images = [
    'assets/images/Miranda.png',
    'assets/images/Prueba1.png',
    'assets/images/Prueba2.png',
  ];
  late Timer _timer;

  // Controller para PageView
  final PageController _pageController = PageController();

  // Datos de ejemplo para las noticias
  final List<NoticiaModel> noticiasCategoria1 = [
    NoticiaModel(
      titulo: 'Reforma Fiscal 2024',
      imagen: 'assets/images/Miranda.png',
    ),
    NoticiaModel(
      titulo: 'Nuevas Deducciones',
      imagen: 'assets/images/Prueba1.png',
    ),
    NoticiaModel(
      titulo: 'Impuestos Digitales',
      imagen: 'assets/images/Prueba2.png',
    ),
    NoticiaModel(
      titulo: 'Declaración Anual',
      imagen: 'assets/images/Miranda.png',
    ),
  ];

  final List<NoticiaModel> noticiasCategoria2 = [
    NoticiaModel(titulo: 'SAT Digital', imagen: 'assets/images/Prueba1.png'),
    NoticiaModel(titulo: 'CFDI 4.0', imagen: 'assets/images/Prueba2.png'),
    NoticiaModel(
      titulo: 'Facturación Electrónica',
      imagen: 'assets/images/Miranda.png',
    ),
    NoticiaModel(
      titulo: 'Buzón Tributario',
      imagen: 'assets/images/Prueba1.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _nextImage();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  void _goToImage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //Hacer que la navegue entre pantallas sea con animaciones
  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });

    if (index == 1) {
      // Navegar a FormCrearCFDIScreen con animación
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FormCrearCFDIScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
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
    } else if (index == 2) {
      // Navegar a ApartadoCCF con animación
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ApartadoCCF(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    } else if (index == 3) {
      _showPlaceholderDialog('Perfil');
    }
  }

  void _showPlaceholderDialog(String pantalla) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$pantalla'),
        content: Text('Pantalla de $pantalla en desarrollo'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeDesigns.buildAppBar(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        children: [
          // PANTALLA 1 - BANNER + ANÁLISIS + OBLIGACIONES
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Carrusel automático de imágenes
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      _images[_currentIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 40, color: Colors.grey),
                              SizedBox(height: 10),
                              Text('Imagen no encontrada'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Indicadores de puntos para el carrusel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _goToImage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Colors.blue
                              : Colors.grey.withOpacity(0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                // Módulo de Análisis de Progreso
                HomeDesigns.buildImageModule(
                  imagePath: 'assets/images/Ana_proge.png',
                  height: 160,
                ),
                SizedBox(height: 10),

                // Módulo de Obligaciones
                HomeDesigns.buildImageModule1(
                  imagePath: 'assets/images/Ana_proge.png',
                  height: 150,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),

          // PANTALLA 2 - GRÁFICA + CFDI
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Gráfica de Ingresos y egresos
                HomeDesigns.buildImageModule2(
                  imagePath: 'assets/images/Miranda.png',
                  height: 280,
                ),
                SizedBox(height: 20),

                // CFDI RECIENTES
                HomeDesigns.buildImageModule2(
                  imagePath: 'assets/images/Miranda.png',
                  height: 280,
                ),
              ],
            ),
          ),

          // PANTALLA 3 - NOTICIAS + ACCESOS RÁPIDOS
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // NOTICIAS
                HomeDesigns.buildImageModule4(
                  imagePath: 'assets/images/Logo.png',
                  height: 180,
                ),
                SizedBox(height: 40),

                // ACCESOS RÁPIDOS
                HomeDesigns.buildAccesosRapidos(context),
              ],
            ),
          ),

          // PANTALLA 4 - NOTICIAS RECOMENDADAS
          Container(
            padding: EdgeInsets.all(20),
            child: _buildNoticiasRecomendadas(),
          ),

          // PANTALLA 5 - GLOSARIO
          Container(
            padding: EdgeInsets.all(20),
            child: HomeDesigns.buildGlosarioTerminos(context),
          ),

          // PANTALLA 6 - PREGUNTAS FRECUENTES
          Container(
            padding: EdgeInsets.all(20),
            child: HomeDesigns.buildPreguntasFrecuentes(context),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/PrincipalA.png',
              width: 30,
              height: 30,
              color: _selectedTab == 0 ? Colors.green : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/CalendarioA.png',
              width: 30,
              height: 30,
              color: _selectedTab == 1 ? Colors.green : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/AsesoriasA.png',
              width: 30,
              height: 30,
              color: _selectedTab == 2 ? Colors.green : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/NotificacionA.png',
              width: 30,
              height: 30,
              color: _selectedTab == 3 ? Colors.green : Colors.grey,
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  // MÉTODOS PARA NOTICIAS RECOMENDADAS
  Widget _buildNoticiasRecomendadas() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Noticias Recomendadas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          _buildCategoriaNoticias(
            titulo: 'Categoría 1',
            noticias: noticiasCategoria1,
            onVerTodo: () {
              // Navegar a la página de categoría 1 de noticias
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      NoticiasRecomendadaCate1(),
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
          SizedBox(height: 30),
          _buildCategoriaNoticias(
            titulo: 'Categoría 2',
            noticias: noticiasCategoria2,
            onVerTodo: () {
              // TODO: Crear página para categoría 2 y navegar aquí
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NoticiasRecomendadaCate2()));
              print('Navegar a categoría 2 de noticias');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoriaNoticias({
    required String titulo,
    required List<NoticiaModel> noticias,
    required VoidCallback onVerTodo, // ← AGREGAR ESTE PARÁMETRO
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titulo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 94, 153, 83),
              ),
              child: IconButton(
                onPressed: onVerTodo, // ← USAR EL PARÁMETRO AQUÍ
                icon: Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              return _buildTarjetaNoticia(noticias[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTarjetaNoticia(NoticiaModel noticia) {
    return GestureDetector(
      onTap: () {
        print('Navegar a noticia: ${noticia.titulo}');
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 15, top: 5, bottom: 5, left: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 122,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  noticia.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.article, size: 30, color: Colors.grey),
                          SizedBox(height: 5),
                          Text(
                            'Noticia',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              child: Text(
                noticia.titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
