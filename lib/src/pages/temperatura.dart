import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';

class Temperatura extends StatefulWidget {
  const Temperatura({Key? key}) : super(key: key);

  @override
  _TemperaturaState createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {
  final items1 = ['Celsius', 'Fahrenheit', 'Kelvin'];
  var items2 = ['Fahrenheit', 'Kelvin'];
  String? valorDropDown1 = 'Celsius', valorDropDown2 = 'Fahrenheit';
  double temp1 = 0, temp2 = 32, min = -273.15, max = 100;
  String unidad = '°F';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Convertidor de Temperatura'),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text('De', style: TextStyle(fontSize: 16)),
            ),
            Container(
              child: _crearDropDown1(),
              padding: const EdgeInsets.all(12),
            ),
            SizedBox(
              width: 128,
              child: _crearSelector(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text('A', style: TextStyle(fontSize: 16)),
            ),
            Container(
              child: _crearDropDown2(),
              padding: const EdgeInsets.all(12),
            ),
            Text(_formatearDouble(temp2) + ' $unidad',
                style: const TextStyle(fontSize: 48)),
          ],
        ),
      ),
    );
  }

  String _formatearDouble(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  /*String _formatearDouble(double n) {
    final fraction = n - n.toInt();
    if (fraction == 0.0) {
      return n.toString();
    }
    var twoDigitFraction = (fraction * 100).truncateToDouble().toInt();
    return '${n.toInt()}.$twoDigitFraction';
  }*/

  Widget _crearDropDown1() {
    return DropdownButton<String>(
      value: valorDropDown1,
      items: items1.map(_itemsDropDown).toList(),
      onChanged: (valor) {
        setState(() {
          valorDropDown1 = valor;
          _calcularTemperatura(temp1);
          switch (valorDropDown1) {
            case 'Fahrenheit':
              items2 = ['Celsius', 'Kelvin'];
              valorDropDown2 = 'Celsius';
              break;
            case 'Kelvin':
              items2 = ['Celsius', 'Fahrenheit'];
              valorDropDown2 = 'Celsius';
              break;
            default:
              items2 = ['Fahrenheit', 'Kelvin'];
              valorDropDown2 = 'Fahrenheit';
          }
        });
      },
    );
  }

  Widget _crearDropDown2() {
    return DropdownButton<String>(
      value: valorDropDown2,
      items: items2.map(_itemsDropDown).toList(),
      onChanged: (valor) {
        setState(() {
          valorDropDown2 = valor;
          _calcularTemperatura(temp1);
        });
      },
    );
  }

  DropdownMenuItem<String> _itemsDropDown(String item) {
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }

  Widget _crearSelector() {
    return SpinBox(
      min: min,
      max: max,
      value: 0,
      spacing: 0,
      direction: Axis.vertical,
      textStyle: const TextStyle(fontSize: 48),
      incrementIcon: const Icon(Icons.keyboard_arrow_up, size: 48),
      decrementIcon: const Icon(Icons.keyboard_arrow_down, size: 48),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
      ),
      onChanged: (valor) {
        setState(() {
          temp1 = valor;
          _calcularTemperatura(temp1);
        });
      },
    );
  }

  _calcularTemperatura(temp) {
    if (valorDropDown1 == 'Celsius' && valorDropDown2 == 'Fahrenheit') {
      temp2 = _convertirCelsiusFahrenheit(temp);
      unidad = '°F';
      min = -273.15;
      max = 100;
    }
    if (valorDropDown1 == 'Celsius' && valorDropDown2 == 'Kelvin') {
      temp2 = _convertirCelsiusKelvin(temp);
      unidad = 'K';
      min = -273.15;
      max = 100;
    }
    if (valorDropDown1 == 'Fahrenheit' && valorDropDown2 == 'Celsius') {
      temp2 = _convertirFahrenheitCelsius(temp);
      unidad = '°C';
      min = -459.67;
      max = 212;
    }
    if (valorDropDown1 == 'Fahrenheit' && valorDropDown2 == 'Kelvin') {
      temp2 = _convertirFahrenheitKelvin(temp);
      unidad = 'K';
      min = -459.67;
      max = 212;
    }
    if (valorDropDown1 == 'Kelvin' && valorDropDown2 == 'Celsius') {
      temp2 = _convertirKelvinCelsius(temp);
      unidad = '°C';
      min = 0;
      max = 373.15;
    }
    if (valorDropDown1 == 'Kelvin' && valorDropDown2 == 'Fahrenheit') {
      temp2 = _convertirKelvinFahrenheit(temp);
      unidad = '°F';
      min = 0;
      max = 373.15;
    }
  }

  _convertirCelsiusFahrenheit(c) => 1.8 * c + 32;
  _convertirFahrenheitCelsius(f) => (f - 32) / 1.8;
  _convertirCelsiusKelvin(c) => c + 273.15;
  _convertirKelvinCelsius(k) => k - 273.15;
  _convertirKelvinFahrenheit(k) => 1.8 * (k - 273.15) + 32;
  _convertirFahrenheitKelvin(f) => (f - 32) / 1.8 + 273.15;
}
