abstract class BaseResponse<T>{
  static final int CODE_SUCCESS=0;

  T data;
  int errorCode;
  String errorMsg;



  BaseResponse(this.data,this.errorCode,this.errorMsg);




}