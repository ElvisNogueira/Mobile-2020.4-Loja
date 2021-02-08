import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loja/components/drawer_loja.dart';
import 'package:loja/shared/Constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProductCreate extends StatefulWidget {
  @override
  _ProductCreateState createState() => _ProductCreateState();
  var maskMoneyFormatter = new MaskTextInputFormatter(mask: "###,##");
}

class _ProductCreateState extends State<ProductCreate> {
  String sizeValue;
  var maskMoneyController = MoneyMaskedTextController();
  var maskdicountController = MoneyMaskedTextController();
  File _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produtos"),
      ),
      drawer: DrawerLoja(),
      body: _body(),
      floatingActionButton: registerButton(),
    );
  }

  Widget registerButton() {
    return FloatingActionButton(
      child: Icon(Icons.save),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Container(height: 40),
              pick_image(),
              Container(height: 20),
              textFieldNome(),
              Container(height: 20),
              dropDownSize(),
              Container(height: 20),
              textFieldPrice(),
              Container(height: 20),
              textFieldDiscount(),
              Container(height: 20),
              dropDownCategory(),
              Container(height: 20),
              textAreaDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pick_image() {
    return FlatButton(
      onPressed: _onclickCamera,
      child: Center(
        child: _file != null
            ? Image.file(_file)
            : Image.asset(
                "assets/images/camera.png",
                width: 100,
              ),
      ),
    );
  }

  Widget textFieldNome() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nome",
        hintText: "Digite o seu nome",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(Icons.person_outlined),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nome inválido.';
        }
        return null;
      },
    );
  }

  Widget textFieldPrice() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(),
      controller: maskMoneyController,
      decoration: InputDecoration(
        labelText: "Preço",
        hintText: "Digite o valor do produto",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(Icons.monetization_on),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Preço inválido.';
        }
        return null;
      },
    );
  }

  Widget textFieldDiscount() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(),
      controller: maskdicountController,
      maxLength: 5,
      decoration: InputDecoration(
        labelText: "Desconto",
        hintText: "Digite a porcentagem de desconto do produto",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(Icons.receipt),
        ),
      ),
      validator: (value) {
        var percent = double.parse("value");

        if (value == null || value.trim().isEmpty) {
          return 'Desconto inválido.';
        }
        return null;
      },
    );
  }

  Widget textAreaDescription() {
    return TextFormField(
      maxLines: 8,
      decoration: InputDecoration(
        labelText: "Descrição",
        hintText: "Digite aqui descrição do produto",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(Icons.description),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nome inválido.';
        }
        return null;
      },
    );
  }

  Widget dropDownSize() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(40)),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.wysiwyg),
            SizedBox(width: 30),
            DropdownButton<String>(
              hint: Text("Selecione o tamanho da peça"),
              value: sizeValue,
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String newValue) {
                setState(() {
                  sizeValue = newValue;
                });
              },
              items: <String>['PP', 'P', 'M', 'GG', 'XG']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownCategory() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(40)),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.category),
            SizedBox(width: 30),
            DropdownButton<String>(
              hint: Text("Selecione uma categoria"),
              value: sizeValue,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String newValue) {
                setState(() {
                  sizeValue = newValue;
                });
              },
              items: <String>['Casual', 'Esporte', 'Formal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onclickCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this._file = image;
    });
  }
}
