//Apex class cannot be static
//Constructor cannot be static

public class Demo2 {
    public String helloWorldString;												//Instance member variables
    Private Static Final String DEFAULT_STRING;								//Static member variables
    
    static{																	//Static initalizer , run only once the class is loaded
        DEFAULT_STRING ='Hello World';
    }
    
    Public Demo2(){															//Constructor without parameters
        this(DEFAULT_STRING);
    }
    
    Public Demo2(String stringToDisplay){									//Overloaded Constructor with parameters
        this.helloWorldString=stringToDisplay;
    }
    
    public void printOutput(){										//Method
        system.debug('Display text '+helloWorldString);
    }
    
    public static void printOutput1(){										//Static Method
        system.debug('Display text from static method');
    }
}