import 'package:flutter/material.dart';
import '../form_crear_cfdi.dart'; // ← AGREGAR ESTE IMPORT

class HomeDesigns {
  static AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      title: Row(
        children: [
          Image.asset(
            'assets/images/Icono.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.account_balance, size: 30);
            },
          ),
          SizedBox(width: 15),
          Text(
            'COCO FISCAL',
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ),
      ],
    );
  }

  // MÓDULO DE ANALISIS DE PROGRSO
  static Widget buildImageModule({
    required String imagePath,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      height: height, // Altura que tú defines
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Imagen no disponible'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //MODULO PARA OBLIGACIONES
  static Widget buildImageModule1({
    required String imagePath,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      height: height, // Altura que tú defines
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Imagen no disponible'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //MODULO PARA Gráfica de ingresos y egresos
  static Widget buildImageModule2({
    required String imagePath,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      height: height, // Altura que tú defines
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Imagen no disponible'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //MODULO PARA NOTIFICACIONES RECIENTES
  static Widget buildImageModule4({
    required String imagePath,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      height: height, // Altura que tú defines
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Imagen no disponible'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // MÓDULO PARA ACCESOS RÁPIDOS
  static Widget buildAccesosRapidos(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Text(
          'Accesos Rápidos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),

        // Primera fila - 3 imágenes
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Registrar CFDI - Ahora navega a FormCrearCFDIScreen
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormCrearCFDIScreen(),
                  ),
                );
              },
              child: _buildAccesoRapido(
                'Registrar CFDI',
                'assets/images/Miranda.png',
                width: 80,
                height: 80,
              ),
            ),
            _buildAccesoRapido(
              'Nuevo Recordatorio',
              'assets/images/Miranda.png',
              width: 80,
              height: 80,
            ),
            _buildAccesoRapido(
              'Consultar Asesor',
              'assets/images/Miranda.png',
              width: 80,
              height: 80,
            ),
          ],
        ),
        SizedBox(height: 20),

        // Segunda fila - 2 imágenes
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAccesoRapido(
              'Generar Reporte',
              'assets/images/Miranda.png',
              width: 80,
              height: 80,
            ),
            SizedBox(width: 20),
            _buildAccesoRapido(
              'Asistente Virtual',
              'assets/images/Miranda.png',
              width: 80,
              height: 80,
            ),
          ],
        ),
      ],
    );
  }

  // Widget individual para cada acceso rápido
  static Widget _buildAccesoRapido(
    String texto,
    String imagenPath, {
    double width = 90,
    double height = 90,
  }) {
    return Column(
      children: [
        Container(
          width: width, // ← TAMAÑO PERSONALIZABLE
          height: height, // ← TAMAÑO PERSONALIZABLE
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagenPath, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        Text(
          texto,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // GLOSARIO DE TÉRMINOS FISCALES - NUEVO MÉTODO
  static Widget buildGlosarioTerminos(BuildContext context) {
    final List<Map<String, String>> terminos = [
      {
        'titulo': 'Término',
        'descripcion': 'Lorem Ipsum has been the industry\'s standard.',
        'imagen': 'assets/images/Miranda.png',
      },
      {
        'titulo': 'Término',
        'descripcion': 'Lorem Ipsum has been the industry\'s standard.',
        'imagen': 'assets/images/Prueba1.png',
      },
      {
        'titulo': 'Término',
        'descripcion': 'Lorem Ipsum has been the industry\'s standard.',
        'imagen': 'assets/images/Prueba2.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado con "Ver todas" - MÁS PEQUEÑO
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Glosario de Términos Fiscales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: Navegar a página completa de glosario
              },
              child: Text(
                'Ver todas',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Tarjetas del glosario
        Column(
          children: terminos.asMap().entries.map((entry) {
            final index = entry.key;
            final termino = entry.value;

            // Alternar diseño: 0=derecha, 1=izquierda, 2=derecha
            final imagenALaDerecha = index % 2 == 0;

            return Column(
              children: [
                _buildTarjetaGlosarioMejorada(
                  context: context, // ← AGREGAR context aquí
                  titulo: termino['titulo']!,
                  descripcion: termino['descripcion']!,
                  imagen: termino['imagen']!,
                  imagenALaDerecha: imagenALaDerecha,
                ),
                if (index < terminos.length - 1) SizedBox(height: 15),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // TARJETA MEJORADA CON IMAGEN REDONDA QUE SE CORTA
  static Widget _buildTarjetaGlosarioMejorada({
    required BuildContext context,
    required String titulo,
    required String descripcion,
    required String imagen,
    required bool imagenALaDerecha,
  }) {
    return Container(
      width: double.infinity,
      height: 170, // ← ALTURA DE LA TARJETA - AJUSTA ESTE VALOR
      // SIN PADDING para que la imagen ocupe todo el espacio
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // CONTENIDO DE TEXTO - POSICIÓN AJUSTADA SEGÚN LADO
          Positioned(
            top: 0,
            bottom: 0,
            left: imagenALaDerecha
                ? 0
                : null, // ← TEXTO A LA IZQUIERDA cuando imagen está a la DERECHA
            right: !imagenALaDerecha
                ? 0
                : null, // ← TEXTO A LA DERECHA cuando imagen está a la IZQUIERDA
            child: Container(
              width: MediaQuery.of(context).size.width * 0.55,
              padding: EdgeInsets.all(16),
              child: _buildContenidoTexto(
                titulo: titulo,
                descripcion: descripcion,
              ),
            ),
          ),

          // IMAGEN REDONDA QUE SE CORTA HACIA AFUERA
          Positioned(
            top: 10,
            bottom: -40,
            right: imagenALaDerecha ? -22 : null,
            left: !imagenALaDerecha ? -24 : null,
            child: Container(
              width: 170,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: ClipOval(
                child: Image.asset(
                  imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.description,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CONTENIDO DE TEXTO SEPARADO - BOTÓN MÁS PEQUEÑO
  static Widget _buildContenidoTexto({
    required String titulo,
    required String descripcion,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Título
        Text(
          titulo,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 6),

        // Descripción
        Text(
          descripcion,
          style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.3),
        ),
        SizedBox(height: 10),

        // Botón "Conocer más" - TAMAÑO FIJO
        Container(
          width: 120,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextButton(
            onPressed: () {
              // TODO: Navegar a detalle del término
            },
            child: Text(
              'Conocer más',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // PREGUNTAS FRECUENTES - NUEVO MÉTODO
  static Widget buildPreguntasFrecuentes(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de la sección
          const Text(
            'Preguntas Frecuentes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),

          // Aquí va el contenido del acordeón
          PreguntasAcordeon(),
        ],
      ),
    );
  }
}

// Widget del acordeón de preguntas - FUERA de la clase HomeDesigns
class PreguntasAcordeon extends StatefulWidget {
  @override
  PreguntasAcordeonState createState() => PreguntasAcordeonState();
}

class PreguntasAcordeonState extends State<PreguntasAcordeon> {
  int? _preguntaSeleccionada;

  final List<Map<String, dynamic>> _preguntas = [
    {
      'titulo': 'Pregunta 1',
      'contenido':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
    },
    {'titulo': 'Pregunta 2', 'contenido': 'Contenido de la pregunta 2...'},
    {
      'titulo': 'Pregunta 3',
      'contenido': '✓ Pregunta 3 marcada como completada',
    },
    {
      'titulo': 'Pregunta 4',
      'contenido': '✓ Pregunta 4 marcada como completada',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_preguntas.length, (index) {
        final bool isSelected = _preguntaSeleccionada == index;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            // La línea inferior SOLO aparece cuando NO está seleccionado
            border: isSelected
                ? null
                : Border(bottom: BorderSide(color: Colors.green, width: 2)),
          ),
          child: Column(
            children: [
              // Título de la pregunta (siempre visible)
              Material(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: isSelected
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      )
                    : BorderRadius.circular(4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_preguntaSeleccionada == index) {
                        _preguntaSeleccionada = null;
                      } else {
                        _preguntaSeleccionada = index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _preguntas[index]['titulo'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.green,
                            ),
                          ),
                        ),
                        Icon(
                          isSelected ? Icons.expand_less : Icons.expand_more,
                          color: isSelected ? Colors.white : Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Contenido expandido con fondo blanco
              if (isSelected)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    _preguntas[index]['contenido'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
