import 'package:flutter/material.dart';
import 'package:sup_transp_app/features/product/presentation/widgets/product_form_page.dart';
import 'package:sup_transp_app/features/product/presentation/widgets/product_list_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            /* Image.asset(
              'assets/images/png/logo.png',
              height: 60,
              width: 60,
            ), */
            //Spacer(),
            /* Container(
              width: 100,
              height: 100,
              child: TabBar(
                labelColor: Color.fromRGBO(4, 2, 46, 1),
                labelStyle: theme.textTheme.headline1,
                indicatorColor: Color.fromRGBO(4, 2, 46, 1),
                unselectedLabelColor: Colors.grey,
                controller: tabController,
                tabs: [
                  Text('listado'),
                  Text('Formulario'),
                ],
              ),
            ), */
          ],
        ),
      ),
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: [ProductListPage(), ProductFormPage()],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: TabBar(
          labelColor: Color.fromRGBO(4, 2, 46, 1),
          //labelStyle: theme.textTheme.headline1,
          indicatorColor: Color.fromRGBO(4, 2, 46, 1),
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: [
            Text('listado'),
            Text('Formulario'),
          ],
        ),
      ),
    );
  }
}
