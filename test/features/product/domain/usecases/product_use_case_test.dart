import 'package:mockito/mockito.dart';
import 'package:sup_transp_app/features/product/domain/repository/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sup_transp_app/features/product/domain/usecases/product_use_case.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  ProductUseCase usecase;
  MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = ProductUseCase(mockProductRepository);
  });

  //final

  //test('show list the products', () async {});
}
