import 'package:flutter/material.dart';
import 'Estilos/form_crearcuenta.dart';

class CategoriaCrearCuentaScreen extends StatefulWidget {
  final Map<String, dynamic> datosUsuario;

  const CategoriaCrearCuentaScreen({super.key, required this.datosUsuario});

  @override
  State<CategoriaCrearCuentaScreen> createState() =>
      _CategoriaCrearCuentaScreenState();
}

class _CategoriaCrearCuentaScreenState
    extends State<CategoriaCrearCuentaScreen> {
  // Lista para almacenar las categorías seleccionadas
  final Set<int> _categoriasSeleccionadas = <int>{};

  //CUANDO PONES UN NUEVO COLOR DEBES QUE REINICIAR LA HOJA PARA QUE SE APLIQUE EL CAMBIO
  // Lista de categorías CON IMÁGENES Y COLORES
  final List<Map<String, dynamic>> _categorias = [
    {
      'id': 1,
      'nombre': 'Categoría 1',
      'imagen': 'assets/images/Clientes.png',
      'color': Color(0xFFE8F5E9),
    }, // Verde muy claro
    {
      'id': 2,
      'nombre': 'Categoría 2',
      'imagen': 'assets/images/Clientes.png',
      'color': Color.fromARGB(255, 140, 226, 140),
    }, // Verde claro
    {
      'id': 3,
      'nombre': 'Categoría 3',
      'imagen': 'assets/images/Clientes.png',
      'color': Color.fromARGB(255, 3, 134, 21),
    }, // Verde oscuro
    {
      'id': 4,
      'nombre': 'Categoría 4',
      'imagen': 'assets/images/Clientes.png',
      'color': Color(0xFFF3E5F5),
    }, // Morado claro
    {
      'id': 5,
      'nombre': 'Categoría 5',
      'imagen': 'assets/images/Clientes.png',
      'color': Color(0xFFE0F2F1),
    }, // Turquesa claro
    {
      'id': 6,
      'nombre': 'Categoría 6',
      'imagen': 'assets/images/Clientes.png',
      'color': Color.fromARGB(255, 255, 3, 41),
    }, // Rojo
    {
      'id': 7,
      'nombre': 'Categoría 7',
      'imagen': 'assets/images/Clientes.png',
      'color': Color(0xFFECEFF1),
    }, // Gris azulado
    {
      'id': 8,
      'nombre': 'Categoría 8',
      'imagen': 'assets/images/Clientes.png',
      'color': Color.fromARGB(255, 82, 83, 69),
    }, // Verde olivo
  ];

  // Método para alternar selección
  void _toggleCategoria(int id) {
    setState(() {
      if (_categoriasSeleccionadas.contains(id)) {
        _categoriasSeleccionadas.remove(id);
      } else {
        _categoriasSeleccionadas.add(id);
      }
    });
  }

  // Método para siguiente
  void _irASiguiente() {
    if (_categoriasSeleccionadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecciona al menos una categoría'),
          backgroundColor: const Color.fromARGB(255, 247, 246, 246),
        ),
      );
      return;
    }
    // Aquí irá la navegación a la siguiente pantalla
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_categoriasSeleccionadas.length} categorías seleccionadas',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Elige lo que más te interesa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '(selecciona todo lo que quieras)',
              style: TextStyle(fontSize: 16, color: AppColors.hintColor),
            ),
            const SizedBox(height: 30),

            // Grid de categorías
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 10,
                childAspectRatio: 1.4,
              ),
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                final bool isSelected = _categoriasSeleccionadas.contains(
                  categoria['id'],
                );

                return CategoriaCard(
                  nombre: categoria['nombre'],
                  imagen: categoria['imagen'],
                  isSelected: isSelected,
                  onTap: () => _toggleCategoria(categoria['id']),
                  color: categoria['color'], // ← PASAR el color
                );
              },
            ),

            const SizedBox(height: 40),

            // Botón Siguiente
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _irASiguiente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Siguiente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SECCIÓN PARA MOSTRAR LOS DATOS RECIBIDOS - DESPUÉS DEL BOTÓN
            _buildDatosUsuario(),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar los datos del usuario
  Widget _buildDatosUsuario() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos del Usuario:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),

          // Información personal
          _buildInfoItem('Nombre:', widget.datosUsuario['nombre']),
          _buildInfoItem('RFC:', widget.datosUsuario['rfc']),
          _buildInfoItem(
            'Régimen Fiscal:',
            widget.datosUsuario['regimenFiscal'],
          ),
          _buildInfoItem('Email:', widget.datosUsuario['email']),
          _buildInfoItem('Celular:', widget.datosUsuario['celular']),
          _buildInfoItem(
            'Fecha Nacimiento:',
            widget.datosUsuario['fechaNacimiento'],
          ),

          const SizedBox(height: 12),
          Text(
            'Domicilio:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),

          // Información de domicilio
          if (widget.datosUsuario['domicilio'] != null) ...[
            _buildInfoItem('Calle:', widget.datosUsuario['domicilio']['calle']),
            _buildInfoItem(
              'Colonia:',
              widget.datosUsuario['domicilio']['colonia'],
            ),
            _buildInfoItem(
              'Número:',
              widget.datosUsuario['domicilio']['numero'],
            ),
            _buildInfoItem('CP:', widget.datosUsuario['domicilio']['cp']),
            _buildInfoItem(
              'Ciudad:',
              widget.datosUsuario['domicilio']['ciudad'],
            ),
            _buildInfoItem(
              'Estado:',
              widget.datosUsuario['domicilio']['estado'],
            ),
            _buildInfoItem('País:', widget.datosUsuario['domicilio']['pais']),
          ],
        ],
      ),
    );
  }

  // Widget auxiliar para mostrar cada item de información
  Widget _buildInfoItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? 'No especificado',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}
