class Response<T> {
  Status status;
  T data;
  String message;

  Response.empty() : status = Status.EMPTY;
  Response.loading() : status = Status.LOADING;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { EMPTY, LOADING, COMPLETED, ERROR }