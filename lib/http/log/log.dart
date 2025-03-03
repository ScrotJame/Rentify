abstract class Log{
  void i(String tag, String context){
    print("[$tag] $context");
  }
  //Error
  void i1(String tag, String context){
    print("[$tag] $context");
  }
  //implements
  void i2(String tag, String context){
    print("[$tag] $context");
  }
}