abstract class HistoryEvent {
  const HistoryEvent();
}

class FetchSales extends HistoryEvent{}

class GetDetailSales extends HistoryEvent{
  final String id_sale;

  GetDetailSales({this.id_sale});
}