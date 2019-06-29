
class SelectedInfo {
  String _transaction;
  String _status;
  String _description;

  SelectedInfo(this._transaction, this._status, [this._description]);

  String get transaction => _transaction;
  String get status => _status;
  String get description => _description;

  set transaction (String transaction) {
    this._transaction = transaction;
  }
  set status (String status) {
    this._status = status;
  }
  set description (String description) {
    this._description = description;
  }
}