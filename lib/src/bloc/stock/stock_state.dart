import 'package:apos/src/models/menuModels.dart';

abstract class StockState {}

class AddStockSuccess extends StockState{}
class AddStockFailure extends StockState{}
class RemoveStockSuccess extends StockState{}
class RemoveStockFailure extends StockState{}

class StockInitialized extends StockState{}
class StockError extends StockState{}