import 'package:flutter/material.dart';
import 'Estilos/diseños_cursos.dart';
import 'Cursos_Educativos_cate1.dart'; // ← IMPORTAR LA NUEVA PÁGINA

class ApartadoACursos extends StatefulWidget {
  @override
  _ApartadoACursosState createState() => _ApartadoACursosState();
}

class _ApartadoACursosState extends State<ApartadoACursos> {
  // Datos de ejemplo para las categorías de cursos
  final List<Map<String, dynamic>> cursosCategoria1 = [
    {'titulo': 'SAT Básico', 'imagen': 'assets/images/Miranda.png'},
    {'titulo': 'RFC y Obligaciones', 'imagen': 'assets/images/curso_rfc.png'},
    {
      'titulo': 'Regímenes Fiscales',
      'imagen': 'assets/images/curso_regimenes.png',
    },
    {'titulo': 'Cédula Fiscal', 'imagen': 'assets/images/curso_cedula.png'},
  ];

  final List<Map<String, dynamic>> cursosCategoria2 = [
    {'titulo': 'CFDI 4.0', 'imagen': 'assets/images/curso_cfdi.png'},
    {'titulo': 'Timbre Digital', 'imagen': 'assets/images/curso_timbre.png'},
    {
      'titulo': 'Complementos',
      'imagen': 'assets/images/curso_complementos.png',
    },
    {'titulo': 'Factura Global', 'imagen': 'assets/images/curso_global.png'},
  ];

  final List<Map<String, dynamic>> cursosCategoria3 = [
    {'titulo': 'Declaración Anual', 'imagen': 'assets/images/curso_anual.png'},
    {
      'titulo': 'Declaración Mensual',
      'imagen': 'assets/images/curso_mensual.png',
    },
    {
      'titulo': 'Pagos Provisionales',
      'imagen': 'assets/images/curso_pagos.png',
    },
    {
      'titulo': 'Devoluciones',
      'imagen': 'assets/images/curso_devoluciones.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CursosDesigns.buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CARRUSEL DE CURSOS POR CATEGORÍAS
            Container(
              padding: EdgeInsets.all(20),
              child: _buildCursosPorCategoria(),
            ),
          ],
        ),
      ),
    );
  }

  // MÉTODOS PARA CURSOS POR CATEGORÍA
  Widget _buildCursosPorCategoria() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //MODULO DE CATEGORÍAS
          CursosDesigns.buildCategoriaCursos(
            titulo: 'Conceptos Básicos',
            cursos: cursosCategoria1,
            onVerTodo: () {
              // Navegar a la página de categoría 1
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CursosEducativosCate1(),
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
          SizedBox(height: 10),
          CursosDesigns.buildCategoriaCursos(
            titulo: 'Facturación Electrónica',
            cursos: cursosCategoria2,
            onVerTodo: () {
              // TODO: Crear página para categoría 2 y navegar aquí
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CursosEducativosCate2()));
              print('Navegar a categoría Facturación Electrónica');
            },
          ),
          SizedBox(height: 10),
          CursosDesigns.buildCategoriaCursos(
            titulo: 'Declaraciones',
            cursos: cursosCategoria3,
            onVerTodo: () {
              // TODO: Crear página para categoría 3 y navegar aquí
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CursosEducativosCate3()));
              print('Navegar a categoría Declaraciones');
            },
          ),
        ],
      ),
    );
  }
}
