class PriorityForString{
  static int priorityForString(String s){
    switch(s){
      case "baixa":
        return 0;
      case "media":
        return 1;
      case "alta":
        return 2;
      default:
        return -1;
    }
  }
}