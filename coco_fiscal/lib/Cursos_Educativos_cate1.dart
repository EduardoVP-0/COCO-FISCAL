import 'package:flutter/material.dart';
import 'Estilos/diseños_categorias.dart';

class CursosEducativosCate1 extends StatefulWidget {
  @override
  _CursosEducativosCate1State createState() => _CursosEducativosCate1State();
}

class _CursosEducativosCate1State extends State<CursosEducativosCate1> {
  // Lista de cursos para esta categoría
  final List<Map<String, dynamic>> cursos = [
    {'titulo': 'SAT Básico', 'imagen': 'assets/images/Miranda.png'},
    {'titulo': 'RFC y Obligaciones', 'imagen': 'assets/images/curso_rfc.png'},
    {
      'titulo': 'Regímenes Fiscales',
      'imagen': 'assets/images/curso_regimenes.png',
    },
    {'titulo': 'Cédula Fiscal', 'imagen': 'assets/images/curso_cedula.png'},
    {'titulo': 'e.firma', 'imagen': 'assets/images/curso_firma.png'},
    {'titulo': 'Contraseña SAT', 'imagen': 'assets/images/curso_password.png'},
    {'titulo': 'Buzón Tributario', 'imagen': 'assets/images/curso_buzon.png'},
    {'titulo': 'Mis Cuentas', 'imagen': 'assets/images/curso_cuentas.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoriasCursosDesigns.buildAppBar(titulo: 'Categoría 1'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // CONTENIDO - 4 FILAS CON 2 TARJETAS CADA UNA
            _buildGridCursos(),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCursos() {
    return Column(
      children: [
        // Fila 1
        _buildFilaCursos(0, 1),
        SizedBox(height: 20),

        // Fila 2
        _buildFilaCursos(2, 3),
        SizedBox(height: 20),

        // Fila 3
        _buildFilaCursos(4, 5),
        SizedBox(height: 20),

        // Fila 4
        _buildFilaCursos(6, 7),
      ],
    );
  }

  Widget _buildFilaCursos(int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: CategoriasCursosDesigns.buildTarjetaCurso(
            titulo: cursos[index1]['titulo'],
            imagen: cursos[index1]['imagen'],
            onTap: () {
              // TODO: Navegar a página específica del curso
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleCurso1()));
              print('Navegar a: ${cursos[index1]['titulo']}');
            },
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: CategoriasCursosDesigns.buildTarjetaCurso(
            titulo: cursos[index2]['titulo'],
            imagen: cursos[index2]['imagen'],
            onTap: () {
              // TODO: Navegar a página específica del curso
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleCurso2()));
              print('Navegar a: ${cursos[index2]['titulo']}');
            },
          ),
        ),
      ],
    );
  }
}
