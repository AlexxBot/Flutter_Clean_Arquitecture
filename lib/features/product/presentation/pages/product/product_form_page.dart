import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sup_transp_app/core/widgets/widgets.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/presentation/bloc/bloc/product_bloc.dart';
//import 'package:flutter_demo/models/product.dart';

class ProductFormPage extends StatefulWidget {
  final String id;
  const ProductFormPage({Key? key, this.id = ""}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late ProductBloc productBloc;
  //late AuthBloc authBloc;

  TextEditingController _id = TextEditingController(text: "");
  TextEditingController _name = TextEditingController(text: "");
  TextEditingController _category = TextEditingController(text: '');
  TextEditingController _price = TextEditingController(text: '0.0');
  TextEditingController _imgURL = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (widget.id.trim() != '') {
      print('entro a recuperar por id desde la vista');
      BlocProvider.of<ProductBloc>(context).add(GetEvent(id: widget.id));
    }
    //productBloc.add(RecuperarEvent(widget.id));

    //authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _submit() {
    final product = Product(
        id: _id.text,
        name: _name.text,
        category: _category.text,
        price: double.parse(_price.text),
        imgURL: _imgURL.text);
    //validar todo con el from validate y save
    BlocProvider.of<ProductBloc>(context).add(SaveEvent(product: product));
  }

  void _delete() {
    BlocProvider.of<ProductBloc>(context).add(DeleteEvent(id: _id.text));
  }

  void _fillForm(Product _product) {
    _id.text = _product.id;
    _name.text = _product.name;
    _category.text = _product.category;
    _price.text = _product.price.toString();
    _imgURL.text = _product.imgURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Formulario"),
        ),
        body: SafeArea(
            child: BlocListener<ProductBloc, ProductState>(
          //bloc: productBloc,
          listener: (context, state) {
            if (state is SavedState) {
              LoadingWidget.hide(context);
            }
            if (state is DeletedState) {
              LoadingWidget.hide(context);
              print("se elimino correctamente");
            }
            if (state is RetrivedState) {
              LoadingWidget.hide(context);
              print(' se recupero correctamente');
              _fillForm(state.product);
            }
            /* if (state is LoadingState) {
              LoadingWidget.show(context);
              //este listener ya esta el widget padre ya no necesario volver a preguntar
              print("esta cargando");
            } */
          },
          child: Form(
            child: ListView(padding: EdgeInsets.all(15), children: [
              TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(hintText: "id"),
                  controller: _id),
              TextFormField(
                  decoration: InputDecoration(hintText: "name"),
                  controller: _name),
              TextFormField(
                  decoration: InputDecoration(hintText: "category"),
                  controller: _category),
              TextFormField(
                  decoration:
                      InputDecoration(hintText: "price", prefixText: "\u0024 "),
                  controller: _price,
                  //inputFormatters: [FilteringTextInputFormatter.allow()],
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ]),
              TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(hintText: "imgURL"),
                  controller: _imgURL)
            ]),
          ),
        )),
        bottomNavigationBar: Container(
            color: Colors.transparent,
            height: 100,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWidget(
                    title: "Delete",
                    onPressed: _delete,
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                  ButtonWidget(
                    title: "Guardar",
                    onPressed: _submit,
                  ),
                ])));
  }
}
