
abstract class OutletEvent {
  const OutletEvent();
}

class FetchingAllOutletStore extends OutletEvent {}

class AddOutletForm extends OutletEvent {
  final String name_outlet;
  final String address_outlet;
  final String phone_outlet;

  AddOutletForm({this.name_outlet, this.address_outlet, this.phone_outlet});
}
