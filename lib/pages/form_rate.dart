import 'package:utilidades_automotivas/controller/engine_rate_controller.dart';
import 'package:utilidades_automotivas/helpers/validtor_helper.dart';
import 'package:utilidades_automotivas/dialogs/result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utilidades_automotivas/utils/menu.dart';

class EngineRatePage extends StatefulWidget {
  @override
  _EngineRateState createState() => _EngineRateState();
}

class _EngineRateState extends State<EngineRatePage> {
  final _formkey = GlobalKey<FormState>();
  final _controller = EngineRateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Taxa de Compressão',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Lista de Taxas de Compressão',
            onPressed: () {
              Navigator.pushNamed(context, '/list_engine');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            tooltip: 'Voltar para Menu inicial',
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          padding: const EdgeInsets.all(20),
          child: _buildForm(),
        ),
      ),
      drawer: menu.buildMenu(context),
    );
  }

  Menu menu = new Menu();

  _buildForm() {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderText('Informe os Dados do Motor'),
          _buildVerticalSpace(),
          _buildTextInputField(
            'Informe o Nome do Veículo:',
            onSaved: _controller.setCarName,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Diâmetro Pistão (milímetros)',
            onSaved: _controller.setEngineDimensions,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Curso Virabrequim (milímetros)',
            onSaved: _controller.setCrankshaftCourse,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Espessura Junta (milímetros)',
            onSaved: _controller.setJointerThinckness,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Diâmetro Junta (milímetros)',
            onSaved: _controller.setJointDiameter,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Volume da Câmara (ml)',
            onSaved: _controller.setChamberVolume,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Volume do pistão (ml)',
            onSaved: _controller.setPistonVolume,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Número de Pistões',
            onSaved: _controller.setNumberOfPistons,
          ),
          _buildCalculateButton(),
        ],
      ),
    );
  }

  _buildNumberInputField(String label, {Function(String) onSaved}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onSaved: onSaved,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.amber[200]),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.grey[700]),
        ),
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
        labelText: label,
      ),
      validator: ValidatorHelper.isValidText,
      keyboardType: TextInputType.number,
    );
  }

  _buildTextInputField(String label, {Function(String) onSaved}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onSaved: onSaved,
      decoration: InputDecoration(
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.amber[200]),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.grey[700]),
        ),
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
        labelText: label,
      ),
      validator: ValidatorHelper.isValidText,
      keyboardType: TextInputType.text,
    );
  }

  _buildCalculateButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
      child: const Text(
        'Calcular',
        style: TextStyle(
          color: Colors.amber,
        ),
      ),
      onPressed: _calculate,
    );
  }

  _buildHeaderText(String label) {
    return Container(
      color: Colors.black,
      height: 40,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildVerticalSpace({double height = 20.0}) {
    return SizedBox(
      height: height,
    );
  }

  void _calculate() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      final result = _controller.calculateRate();

      showDialog(
        context: context,
        builder: (context) => ResultDialog(result),
      );
    }
  }
}
