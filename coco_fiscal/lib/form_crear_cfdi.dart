import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Estilos/form_crearcuenta.dart';

class FormCrearCFDIScreen extends StatefulWidget {
  const FormCrearCFDIScreen({super.key});

  @override
  State<FormCrearCFDIScreen> createState() => _FormCrearCFDIScreenState();
}

class _FormCrearCFDIScreenState extends State<FormCrearCFDIScreen> {
  // Controladores para campos de texto
  final TextEditingController _folioFiscalController = TextEditingController();
  final TextEditingController _folioController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _serieController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _usoCfdController = TextEditingController();

  // CONTROLLERS PARA EMISOR
  final TextEditingController _rfcEmisorController = TextEditingController();
  final TextEditingController _nombreEmisorController = TextEditingController();

  // CONTROLLERS PARA RECEPTOR
  final TextEditingController _rfcReceptorController = TextEditingController();
  final TextEditingController _nombreReceptorController =
      TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();

  // Controladores para Producto/Servicio
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _valorUnitarioController =
      TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _tasaController = TextEditingController();

  // Variables para combobox Producto/Servicio
  String? _unidadValue;
  String? _impuestoValue;
  String? _tipoValue;

  // Listas para los combobox
  final List<String> _unidades = [
    'Pieza',
    'Kilogramo',
    'Litro',
    'Metro',
    'Caja',
    'Paquete',
  ];

  final List<String> _impuestos = ['IVA', 'ISR', 'IEPS'];
  final List<String> _tipos = ['Tasa', 'Cuota'];

  // Lista para almacenar los productos agregados
  List<Producto> _productos = [];

  // Variables para los campos de selección
  String? _monedaValue;
  String? _formaPagoValue;

  bool _guardando = false;

  // Método para agregar producto
  void _agregarProducto() {
    // Validar campos obligatorios
    if (_claveController.text.isEmpty ||
        _cantidadController.text.isEmpty ||
        _valorUnitarioController.text.isEmpty ||
        _descripcionController.text.isEmpty) {
      _mostrarError('Por favor complete todos los campos obligatorios');
      return;
    }

    // Calcular importes
    double cantidad = double.tryParse(_cantidadController.text) ?? 0;
    double valorUnitario = double.tryParse(_valorUnitarioController.text) ?? 0;
    double importe = cantidad * valorUnitario;

    double tasa = double.tryParse(_tasaController.text) ?? 0;
    double importeImpuesto = importe * (tasa / 100);

    Producto nuevoProducto = Producto(
      clave: _claveController.text,
      cantidad: cantidad.toStringAsFixed(0), // Sin decimales para cantidad
      unidad: _unidadValue ?? 'Pieza',
      valorUnitario: valorUnitario.toStringAsFixed(2),
      importe: importe.toStringAsFixed(2),
      descripcion: _descripcionController.text,
      impuesto: _impuestoValue ?? 'IVA',
      tipo: _tipoValue ?? 'Tasa',
      tasaCuota: tasa.toStringAsFixed(2),
      importeImpuesto: importeImpuesto.toStringAsFixed(2),
    );

    setState(() {
      _productos.add(nuevoProducto);
    });

    // Limpiar campos después de agregar
    _limpiarCamposProducto();

    _mostrarExito('Producto agregado correctamente');
  }

  //METODO PARA SABER QUE CAMPOS FALTAN
  // Método para DEBUG - Mostrar todos los datos que se enviarán
  void _mostrarDatosEnviados(Producto primerProducto) {
    print('=== DATOS A ENVIAR AL SERVIDOR ===');
    print('folio_fiscal: ${_folioFiscalController.text}');
    print('folio: ${_folioController.text}');
    print('fecha: ${_fechaController.text}');
    print('serie: ${_serieController.text}');
    print('hora: ${_horaController.text}');
    print('uso_cfdi: ${_usoCfdController.text}');
    print('moneda: ${_monedaValue ?? "NULL"}');
    print('forma_pago: ${_formaPagoValue ?? "NULL"}');
    print('rfc_emisor: ${_rfcEmisorController.text}');
    print('nombre_emisor: ${_nombreEmisorController.text}');
    print('rfc_receptor: ${_rfcReceptorController.text}');
    print('nombre_receptor: ${_nombreReceptorController.text}');
    print('codigo_postal: ${_codigoPostalController.text}');
    print('clave_producto: ${primerProducto.clave}');
    print('cantidad_producto: ${primerProducto.cantidad}');
    print('unidad_producto: ${primerProducto.unidad}');
    print('valor_unitario_producto: ${primerProducto.valorUnitario}');
    print('importe_producto: ${primerProducto.importe}');
    print('descripcion_producto: ${primerProducto.descripcion}');
    print('impuesto_producto: ${primerProducto.impuesto}');
    print('tipo_impuesto_producto: ${primerProducto.tipo}');
    print('tasa_cuota_producto: ${primerProducto.tasaCuota}');
    print('importe_impuesto_producto: ${primerProducto.importeImpuesto}');
    print('===================================');
  }

  // Método para guardar CFDI en la base de datos
  Future<void> _guardarCFDI() async {
    if (_productos.isEmpty) {
      _mostrarError('Agrega al menos un producto antes de guardar');
      return;
    }

    // Validar campos obligatorios
    if (_rfcEmisorController.text.isEmpty ||
        _nombreEmisorController.text.isEmpty ||
        _rfcReceptorController.text.isEmpty ||
        _nombreReceptorController.text.isEmpty) {
      _mostrarError('Complete los datos del emisor y receptor');
      return;
    }

    setState(() {
      _guardando = true;
    });

    try {
      // Tomar el primer producto
      Producto primerProducto = _productos.first;

      // DEBUG: Mostrar datos en consola
      _mostrarDatosEnviados(primerProducto);

      //CAMBIAR EL LINK YA QUE ESTE ES DE MANERA
      final url = Uri.parse('http://192.168.100.8/api_coco/agregar_cfdi.php');

      Map<String, dynamic> datosCFDI = {
        'folio_fiscal': _folioFiscalController.text,
        'folio': _folioController.text,
        'fecha': _fechaController.text,
        'serie': _serieController.text,
        'hora': _horaController.text,
        'uso_cfdi': _usoCfdController.text,
        'moneda': _monedaValue ?? '',
        'forma_pago': _formaPagoValue ?? '',
        'rfc_emisor': _rfcEmisorController.text,
        'nombre_emisor': _nombreEmisorController.text,
        'rfc_receptor': _rfcReceptorController.text,
        'nombre_receptor': _nombreReceptorController.text,
        'codigo_postal': _codigoPostalController.text,
        'clave_producto': primerProducto.clave,
        'cantidad_producto': primerProducto.cantidad,
        'unidad_producto': primerProducto.unidad,
        'valor_unitario_producto': primerProducto.valorUnitario,
        'importe_producto': primerProducto.importe,
        'descripcion_producto': primerProducto.descripcion,
        'impuesto_producto': primerProducto.impuesto,
        'tipo_impuesto_producto': primerProducto.tipo,
        'tasa_cuota_producto': primerProducto.tasaCuota,
        'importe_impuesto_producto': primerProducto.importeImpuesto,
      };

      print('JSON enviado: ${jsonEncode(datosCFDI)}'); // DEBUG

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(datosCFDI),
      );

      print('Respuesta del servidor: ${response.statusCode}'); // DEBUG
      print('Cuerpo de respuesta: ${response.body}'); // DEBUG

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _mostrarExito(data['message']);
          _limpiarFormulario();
        } else {
          _mostrarError(data['message']);
        }
      } else {
        _mostrarError('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error completo: $e'); // DEBUG
      _mostrarError('Error de conexión: $e');
    } finally {
      setState(() {
        _guardando = false;
      });
    }
  }

  void _limpiarFormulario() {
    _folioFiscalController.clear();
    _folioController.clear();
    _fechaController.clear();
    _serieController.clear();
    _horaController.clear();
    _usoCfdController.clear();
    _rfcEmisorController.clear();
    _nombreEmisorController.clear();
    _rfcReceptorController.clear();
    _nombreReceptorController.clear();
    _codigoPostalController.clear();
    _limpiarCamposProducto();
    setState(() {
      _productos.clear();
      _monedaValue = null;
      _formaPagoValue = null;
    });
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _mostrarExito(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _limpiarCamposProducto() {
    _claveController.clear();
    _cantidadController.clear();
    _valorUnitarioController.clear();
    _descripcionController.clear();
    _tasaController.clear();
    setState(() {
      _unidadValue = null;
      _impuestoValue = null;
      _tipoValue = null;
    });
  }

  void _eliminarProducto(int index) {
    setState(() {
      _productos.removeAt(index);
    });
    _mostrarExito('Producto eliminado');
  }

  // Método para construir el resumen final
  Widget _buildResumenFinal() {
    double subtotal = _productos.fold(
      0,
      (sum, producto) => sum + (double.tryParse(producto.importe) ?? 0),
    );
    double impuestos = _productos.fold(
      0,
      (sum, producto) => sum + (double.tryParse(producto.importeImpuesto) ?? 0),
    );
    double total = subtotal + impuestos;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Subtotal: \$${subtotal.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            'Impuestos trasladados: \$${impuestos.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Divider(),
          Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CAMPO FOLIO FISCAL
            CfdTextField(
              controller: _folioFiscalController,
              hintText: 'Folio Fiscal',
            ),
            const SizedBox(height: 16),

            // FOLIO Y FECHA EN MISMA FILA
            FolioFechaLayout(
              folioController: _folioController,
              fechaController: _fechaController,
            ),
            const SizedBox(height: 16),

            // SERIE Y HORA EN MISMA FILA
            SerieHoraLayout(
              serieController: _serieController,
              horaController: _horaController,
            ),
            const SizedBox(height: 16),

            // MONEDA Y FORMA DE PAGO EN MISMA FILA
            MonedaFormaPagoLayout(
              monedaValue: _monedaValue,
              formaPagoValue: _formaPagoValue,
              onMonedaChanged: (newValue) {
                setState(() {
                  _monedaValue = newValue;
                });
              },
              onFormaPagoChanged: (newValue) {
                setState(() {
                  _formaPagoValue = newValue;
                });
              },
            ),
            const SizedBox(height: 16),

            // USO DE CFDI
            CfdTextField(
              controller: _usoCfdController,
              hintText: 'Uso de CFDI',
            ),
            const SizedBox(height: 20),

            // SECCIÓN DATOS DEL EMISOR (DEBAJO DE USO DE CFDI)
            SeccionConTitulo(
              titulo: 'DATOS DEL EMISOR',
              children: [
                Text('RFC del emisor', style: AppTextStyles.label),
                CfdTextFieldBlanco(controller: _rfcEmisorController),
                const SizedBox(height: 12),
                Text('Nombre del emisor', style: AppTextStyles.label),
                CfdTextFieldBlanco(controller: _nombreEmisorController),
              ],
            ),
            const SizedBox(height: 20),

            // SECCIÓN DATOS DEL RECEPTOR (DEBAJO DE DATOS DEL EMISOR)
            SeccionConTitulo(
              titulo: 'DATOS DEL RECEPTOR',
              children: [
                // RFC DEL RECEPTOR Y CÓDIGO POSTAL EN MISMA FILA
                Row(
                  children: [
                    // RFC del receptor
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('RFC del receptor', style: AppTextStyles.label),
                          CfdTextFieldBlanco(
                            controller: _rfcReceptorController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Código Postal
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código Postal', style: AppTextStyles.label),
                          CfdTextFieldBlanco(
                            controller: _codigoPostalController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Nombre del receptor
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre del receptor', style: AppTextStyles.label),
                    CfdTextFieldBlanco(controller: _nombreReceptorController),
                  ],
                ),
              ],
            ),

            // DATOS DEL PRODUCTO/SERVICIO
            const SizedBox(height: 20),
            ProductoServicioLayout(
              claveController: _claveController,
              cantidadController: _cantidadController,
              valorUnitarioController: _valorUnitarioController,
              descripcionController: _descripcionController,
              tasaController: _tasaController,
              unidadValue: _unidadValue,
              impuestoValue: _impuestoValue,
              tipoValue: _tipoValue,
              unidades: _unidades,
              impuestos: _impuestos,
              tipos: _tipos,
              onUnidadChanged: (newValue) {
                setState(() {
                  _unidadValue = newValue;
                });
              },
              onImpuestoChanged: (newValue) {
                setState(() {
                  _impuestoValue = newValue;
                });
              },
              onTipoChanged: (newValue) {
                setState(() {
                  _tipoValue = newValue;
                });
              },
              onAgregar: _agregarProducto,
              onEliminar: _limpiarCamposProducto,
            ),

            // TABLA DE PRODUCTOS
            const SizedBox(height: 20),
            TablaProductos(
              productos: _productos,
              onEliminar: _eliminarProducto,
            ),

            // RESUMEN FINAL
            if (_productos.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildResumenFinal(),
            ],

            const SizedBox(height: 20),

            // BOTÓN GUARDAR
            _guardando
                ? Center(child: CircularProgressIndicator())
                : GuardarCfdButton(
                    onPressed: _guardarCFDI,
                    disabled: _productos.isEmpty,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _folioFiscalController.dispose();
    _folioController.dispose();
    _fechaController.dispose();
    _serieController.dispose();
    _horaController.dispose();
    _usoCfdController.dispose();
    _rfcEmisorController.dispose();
    _nombreEmisorController.dispose();
    _rfcReceptorController.dispose();
    _nombreReceptorController.dispose();

    // CONTROLLERS PARA PRODUCTO/SERVICIO
    _claveController.dispose();
    _cantidadController.dispose();
    _valorUnitarioController.dispose();
    _descripcionController.dispose();
    _tasaController.dispose();

    super.dispose();
  }
}
