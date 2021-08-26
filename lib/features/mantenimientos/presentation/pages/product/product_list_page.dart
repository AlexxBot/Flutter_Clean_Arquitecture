import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sup_transp_app/core/widgets/loading-widget.dart';
import 'package:sup_transp_app/features/auth/presentation/pages/menu_page.dart';
import 'package:sup_transp_app/features/mantenimientos/domain/entities/product.dart';

import 'package:sup_transp_app/features/mantenimientos/presentation/bloc/bloc/product_bloc.dart';
import 'package:sup_transp_app/features/mantenimientos/presentation/pages/product/product_form_page.dart';

class ProductListPage extends StatefulWidget {
  final String titulo;
  const ProductListPage({Key? key, this.titulo = 'Items'}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductBloc productBloc;

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    BlocProvider.of<ProductBloc>(context).add(ListEvent());
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    BlocProvider.of<ProductBloc>(context).add(ListEvent());
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      drawer: MenuPage(),
      appBar: AppBar(title: Text(widget.titulo)),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: BlocListener<ProductBloc, ProductState>(
          //bloc: BlocProvider.of<ProductBloc>(context),
          listener: (context, state) {
            if (state is LoadingState) {
              LoadingWidget.show(context);
              print(' se esta mostrando el loading para listar');
            }
            if (state is ErrorState) {
              LoadingWidget.hide(context);
              print('hubo un error');
            }
            if (state is ListedState) {
              LoadingWidget.hide(context);
              products = state.products;
              print('se va a listar correctamente');
            }
          },

          /* listenWhen: (previousState, state){
            if(previousState is )
          }, */
          child: BlocBuilder<ProductBloc, ProductState>(
            //bloc: productBloc,
            builder: (context, state) {
              /* if (state is ListedState) {
                return ProductList(products: state.products);
              } else {
                return Center(child: Text("Hola Mundo"));
              } */
              return ProductList(products: products);
              /* else { 
                return Center(child: CircularProgressIndicator());
              } */
            },
          ),
        ),
      )

      /* RefreshIndicator(
            child: FutureBuilder(
              future: ,
          builder: (context, products) {
            return ListView(

            )
          },
        ),
        onRefresh: _refresh,) */

      /* ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(productList[index].name),
                subtitle: Text(productList[index].category));
            //leading: Icon(child: Text(index.toString())));
          },
          itemCount: productList.length,
        ) */
      /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(productList[index].name),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                ),
                onTap: () => accion(index, productList[index].id),
              );
            },
            itemCount: productList.length,
          ),
        )*/
      ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (productContext) => ProductFormPage())),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(this.products[index].name),
            subtitle: Text(this.products[index].category),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<ProductBloc>(
                      create: (context) =>
                          BlocProvider.of<ProductBloc>(context),
                      child: ProductFormPage(
                        id: this.products[index].id,
                      )),
                )),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
