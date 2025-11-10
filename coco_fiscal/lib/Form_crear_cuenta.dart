import 'dart:io';
import 'package:flutter/material.dart';
import 'Estilos/form_crearcuenta.dart';

//IR A PAGINAS CON BOTON
import 'categoria_crear_cuenta.dart'; // Ajusta la ruta según tu proyecto
import 'Apartado_A_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crear Cuenta',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const CrearCuentaScreen(),
    );
  }
}

class CrearCuentaScreen extends StatefulWidget {
  const CrearCuentaScreen({super.key});

  @override
  State<CrearCuentaScreen> createState() => _CrearCuentaScreenState();
}

class _CrearCuentaScreenState extends State<CrearCuentaScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _regimenController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  String _selectedLada = '+52';
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _fechaNacimientoController =
      TextEditingController();

  // AGREGAR ESTA VARIABLE
  bool _aceptoTerminos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Cuenta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de perfil con botón +
            ProfileImagePicker(
              onImageSelected: (File? image) {
                // Aquí manejas la imagen cuando se seleccione
                debugPrint('Imagen seleccionada: $image');
              },
            ),
            const SizedBox(height: 30),

            // Campo Nombre
            Text(
              'Nombre ${AppLabels.requiredIndicator}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            CustomTextField(controller: _nombreController),
            const SizedBox(height: 20),

            // Campo RFC
            Text(
              'RFC ${AppLabels.requiredIndicator}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            CustomTextField(controller: _rfcController),
            const SizedBox(height: 20),

            // Campo Régimen Fiscal
            Text(
              'Régimen Fiscal ${AppLabels.requiredIndicator}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            CustomTextField(controller: _regimenController),
            const SizedBox(height: 20),

            // Campo Correo Electrónico
            Text(
              'Correo Electrónico ${AppLabels.requiredIndicator}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            CustomTextField(controller: _emailController),
            const SizedBox(height: 20),

            // Campo Contraseña
            Text(
              'Contraseña ${AppLabels.requiredIndicator}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            CustomTextField(controller: _passwordController, obscureText: true),
            const SizedBox(height: 20),

            // Campo Número de Celular
            Text('Número de Celular', style: AppTextStyles.label),
            const SizedBox(height: 8),
            Row(
              children: [
                // Combobox para LADA
                Container(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    value: _selectedLada,
                    items: const [
                      DropdownMenuItem(value: '+52', child: Text('+52')),
                      DropdownMenuItem(value: '+55', child: Text('+55')),
                      DropdownMenuItem(value: '+90', child: Text('+90')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedLada = value!;
                      });
                    },
                    decoration: AppDropdownStyles.dropdownDecoration.copyWith(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.inputBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.inputBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.focusedBorderColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                // Campo para número telefónico (PEGADO)
                Expanded(
                  child: TextField(
                    controller: _celularController,
                    keyboardType: TextInputType.phone,
                    style: AppTextStyles.textField,
                    decoration: InputDecoration(
                      hintStyle: AppTextStyles.hint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.inputBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.inputBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.focusedBorderColor,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.inputFillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            //Campo Domicilio
            Text(
              'Domicilio ${AppLabels.requiredIndicator}',
              style: AppTextStyles.label,
            ),

            //Calle
            Text(
              'Calle ${AppLabels.requiredIndicator}',
              style: AppTextStyles.labelCalle,
            ),
            const SizedBox(height: 8),
            CustomTextField(controller: _calleController),
            const SizedBox(height: 20),

            // Colonia y Número en misma fila
            AppLayoutStyles.coloniaNumeroLayout(
              coloniaController: _coloniaController,
              numeroController: _numeroController,
              flexColonia: 3, // Prueba diferentes valores
              flexNumero: 2, // Prueba diferentes valores
            ),
            const SizedBox(height: 20),

            // Código Postal y Ciudad en misma fila
            AppLayoutStyles.cpCiudadLayout(
              cpController: _cpController,
              ciudadController: _ciudadController,
              flexCP: 2, // CP angosto (25%)
              flexCiudad: 3, // Ciudad ancho (75%)
            ),
            const SizedBox(height: 20),

            // Estado y País en misma fila (50%/50%)
            AppLayoutStyles.estadoPaisLayout(
              estadoController: _estadoController,
              paisController: _paisController,
              flexEstado: 1, // 50%
              flexPais: 1, // 50%
            ),
            const SizedBox(height: 20),

            // Fecha de Nacimiento con calendario
            DatePickerField(
              controller: _fechaNacimientoController,
              label: 'Fecha de Nacimiento ${AppLabels.requiredIndicator}',
            ),
            const SizedBox(height: 20),

            // ... después de tus últimos campos

            // Términos y condiciones
            TerminosCondiciones(
              value: _aceptoTerminos,
              onChanged: (bool? value) {
                setState(() {
                  _aceptoTerminos = value ?? false;
                });
              },
            ),
            const SizedBox(height: 30),

            // Botón Crear Cuenta
            // Botón Crear Cuenta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _aceptoTerminos ? _crearCuenta : null,
                style: AppButtonStyles.primaryButton,
                child: Text('Siguiente', style: AppTextStyles.botonTexto),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApartadoAHome()),
                  );
                },
                style: AppButtonStyles.primaryButton,
                child: Text('Siguiente', style: AppTextStyles.botonTexto),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _crearCuenta() {
    // Recopilar todos los datos
    final datosUsuario = {
      'nombre': _nombreController.text,
      'rfc': _rfcController.text,
      'regimenFiscal': _regimenController.text,
      'email': _emailController.text,
      'celular': '$_selectedLada ${_celularController.text}',
      'domicilio': {
        'calle': _calleController.text,
        'colonia': _coloniaController.text,
        'numero': _numeroController.text,
        'cp': _cpController.text,
        'ciudad': _ciudadController.text,
        'estado': _estadoController.text,
        'pais': _paisController.text,
      },
      'fechaNacimiento': _fechaNacimientoController.text,
    };

    // Navegar a la pantalla de categorías pasando los datos
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            CategoriaCrearCuentaScreen(datosUsuario: datosUsuario),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _rfcController.dispose();
    _regimenController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _celularController.dispose();
    _calleController.dispose();
    _cpController.dispose();
    _ciudadController.dispose();
    _estadoController.dispose();
    _paisController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }
}
