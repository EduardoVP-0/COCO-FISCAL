import 'package:flutter/material.dart';
import 'Estilos/diseños_categoria_noticias.dart';

class NoticiasRecomendadaCate1 extends StatefulWidget {
  @override
  _NoticiasRecomendadaCate1State createState() =>
      _NoticiasRecomendadaCate1State();
}

class _NoticiasRecomendadaCate1State extends State<NoticiasRecomendadaCate1> {
  // Lista de noticias para esta categoría
  final List<Map<String, dynamic>> noticias = [
    {
      'titulo': 'Reformas Fiscales 2024',
      'imagen': 'assets/images/noticia_reformas.png',
    },
    {
      'titulo': 'Nuevas Obligaciones',
      'imagen': 'assets/images/noticia_obligaciones.png',
    },
    {'titulo': 'Declaraciones', 'imagen': 'assets/images/noticia_cambios.png'},
    {'titulo': 'Plazos Fiscales', 'imagen': 'assets/images/noticia_plazos.png'},
    {
      'titulo': 'Actualización CFDI',
      'imagen': 'assets/images/noticia_cfdi.png',
    },
    {'titulo': 'Guía Rápida SAT', 'imagen': 'assets/images/noticia_guia.png'},
    {
      'titulo': 'Deducciones Personales',
      'imagen': 'assets/images/noticia_deducciones.png',
    },
    {'titulo': 'Tips Fiscales', 'imagen': 'assets/images/noticia_tips.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoriaNoticiasDesigns.buildAppBar(titulo: 'Noticias Fiscales'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // CONTENIDO - 4 FILAS CON 2 TARJETAS CADA UNA
            _buildGridNoticias(),
          ],
        ),
      ),
    );
  }

  Widget _buildGridNoticias() {
    return Column(
      children: [
        // Fila 1
        _buildFilaNoticias(0, 1),
        SizedBox(height: 20),

        // Fila 2
        _buildFilaNoticias(2, 3),
        SizedBox(height: 20),

        // Fila 3
        _buildFilaNoticias(4, 5),
        SizedBox(height: 20),

        // Fila 4
        _buildFilaNoticias(6, 7),
      ],
    );
  }

  Widget _buildFilaNoticias(int index1, int index2) {
    return Row(
      children: [
        Expanded(
          child: CategoriaNoticiasDesigns.buildTarjetaNoticia(
            titulo: noticias[index1]['titulo'],
            imagen: noticias[index1]['imagen'],
            onTap: () {
              // TODO: Navegar a página específica de la noticia
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleNoticia1()));
              print('Navegar a noticia: ${noticias[index1]['titulo']}');
            },
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: CategoriaNoticiasDesigns.buildTarjetaNoticia(
            titulo: noticias[index2]['titulo'],
            imagen: noticias[index2]['imagen'],
            onTap: () {
              // TODO: Navegar a página específica de la noticia
              // Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleNoticia2()));
              print('Navegar a noticia: ${noticias[index2]['titulo']}');
            },
          ),
        ),
      ],
    );
  }
}
