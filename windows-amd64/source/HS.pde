class HS implements Comparable<HS>{
String name;
Integer Score;
  public HS(String n , int Score){
name = n;
this.Score = Score;
}
 public int compareTo(HS other){
   return Score.compareTo(other.Score);
   
   
 }
  
  
  
  
  
  
  
  
  
  
}
