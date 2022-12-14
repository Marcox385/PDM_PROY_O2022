/*
 * Proyecto PDM
 * IS727272 - Cordero Hernández, Marco Ricardo
 * IS727366 - Rodríguez Castro, Carlos Eduardo
 * 
 * Contenedor para seleccionar pantallas del paciente
 */
import 'package:dental385/Pages/Paciente/pacient_service.dart';
import 'package:dental385/Pages/Paciente/Home/home_paciente.dart';
import 'package:dental385/Pages/Paciente/Misc/historial_paciente.dart';
import 'package:dental385/Pages/Paciente/Misc/promo_mes_paciente.dart';
import 'package:dental385/Pages/Paciente/Misc/hacer_cita.dart';
import 'package:dental385/Pages/Paciente/Profile/perfil_paciente.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPaciente extends StatefulWidget {
  const MainPaciente({super.key});

  @override
  State<MainPaciente> createState() => _MainPacienteState();
}

class _MainPacienteState extends State<MainPaciente> {
  int _currentPageIndex = 0;
  final _pagesNamesList = [
    'Inicio',
    'Perfil',
    'Nueva cita',
    'Historial',
    'Salir'
  ];
  final _pagesList = [
    HomePaciente(),
    PerfilPaciente(),
    HacerCita(),
    HistorialPaciente(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PacientService().pacientFirstName(),
      builder: ((ctx, data) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Bienvenid@ ${data.data}'),
            actions: [
              IconButton(
                  icon: Icon(FontAwesomeIcons.gift),
                  tooltip: 'Promociones del mes',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PromoMesPaciente()));
                  })
            ],
          ),
          body: IndexedStack(
            index: _currentPageIndex,
            children: _pagesList,
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentPageIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: _pagesNamesList[0]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: _pagesNamesList[1]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle), label: _pagesNamesList[2]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt), label: _pagesNamesList[3]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.logout), label: _pagesNamesList[4])
              ],
              onTap: (index) {
                if (index == 4) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text('¿Desea salir?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: const Text('Ok'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar'),
                        )
                      ],
                    ),
                  );
                } else {
                  setState(() {
                    _currentPageIndex = index;
                  });
                }
              }),
        );
      }),
    );
  }
}
