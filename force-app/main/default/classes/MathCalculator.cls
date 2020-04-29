public class MathCalculator {
    public static void add(Integer n1,Integer n2){
        Integer result=n1+n2;
        printoutput(result);
    }
    public static void multiply(Integer n1,Integer n2){
        Integer result=n1*n2;
        printoutput(result);
    }
    public static void printoutput(Integer result){
        system.debug('result = '+result);
    }
}