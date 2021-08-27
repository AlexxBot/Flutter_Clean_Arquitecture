import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sup_transp_app/core/widgets/widgets.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/presentation/bloc/bloc/product_bloc.dart';
import 'package:sup_transp_app/features/product/presentation/widgets/container_image_widget.dart';
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
      BlocProvider.of<ProductBloc>(context).add(GetEvent(id: widget.id));
    }

    _imgURL.addListener(() {
      //BlocProvider.of<ProductBloc>(context).add(GetImage(url: _imgURL.text));
      /* if (!_imgURL.) {
        BlocProvider.of<PersonaBloc>(context)
            .add(RecuperarPersonaEvent(_codPersona.text));
      } */
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _id.dispose();
    _name.dispose();
    _category.dispose();
    _price.dispose();
    _imgURL.dispose();
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackWidget(Text("Se guardo correctamente"),
                    backgroundColor: Theme.of(context).primaryColor),
              );
            }
            if (state is DeletedState) {
              LoadingWidget.hide(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackWidget(Text("Se recupero correctamente")));
            }
            if (state is RetrivedState) {
              LoadingWidget.hide(context);
              _fillForm(state.product);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackWidget(Text("Se recupero correctamente")));
              /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('se recupero correctamente'),
                duration: const Duration(seconds: 1),
                action: SnackBarAction(
                  label: 'ACTION',
                  onPressed: () {},
                ),
              )); */
            }
            //esto deberia de manejarse aqui , pero debido a que en el ancestro ya se condiciona este estado, ya no es necesario duplicar su logica
            /* if (state is LoadingState) {
              LoadingWidget.show(context);
              //este listener ya esta el widget padre ya no necesario volver a preguntar
              print("esta cargando");
            } */
          },
          child: Form(
            child: ListView(padding: EdgeInsets.all(15), children: [
              Visibility(
                visible: false,
                child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(),
                    controller: _id),
              ),
              TextFormField(
                  decoration:
                      InputDecoration(hintText: "name", labelText: "Name"),
                  controller: _name),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "category", labelText: "Category"),
                  controller: _category),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: "price",
                      prefixText: "\u0024 ",
                      labelText: "Price"),
                  controller: _price,
                  //inputFormatters: [FilteringTextInputFormatter.allow()],
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ]),
              TextFormField(
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: "imgURL"),
                controller: _imgURL,
              ),
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 300,
                  child: Center(
                    child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                      if (state is RetrivedState)
                        return ContainerImage(
                          url: state.product.imgURL,
                          /* height: 200, */
                        );
                      else {
                        return Text("No image Provided");
                      }
                    }),
                  ))
            ]),
          ),
        )),
        bottomNavigationBar: Container(
            color: Colors.transparent,
            height: 80,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
