class Response<T> {
  Status status;
  T data;
  String message;

  Response.loading() : status = Status.LOADING;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status";
  }
}

enum Status { LOADING, COMPLETED, ERROR }