package uk.ac.manchester.cs.msc.ssd.domcalc.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import uk.ac.manchester.cs.msc.ssd.domcalc.*;


public class CalculatorImpl {

	static private final String ELEMexpr = "expression";
	static private final String ELEMplus = "plus";
	static private final String ELEMtimes = "times";
	static private final String ELEMminus = "minus";
	static private final String ELEMint = "int";
	static private final String ATTRvalue = "value";
	
    public CalculatorImpl() {
    }

    /**
     * Computes the result to a calculation that is specified by an XML document
     * @param schemaFile File containing RNC schema
     * @param testFile File containing test XML document
     * @param testDoc is the DOM representation of the test XML document
     * @return The result of the calculation.
     */
    public int computeResult(File schemaFile, File testFile, Document testDoc) throws NumberFormatException {
    	int result = 0;
    	System.out.println("Running calculator...");
        // TODO: Implementation.
        // TODO: Validate test-file against schema using SchemaValidator class
        boolean validation = SchemaValidator.validate(schemaFile, testFile);
        System.out.println("Validation of the file against schema is " +validation);
        if(validation){ //testfile validate sucessfully
	        //check non-munberic argument
        	NodeList intEle = testDoc.getElementsByTagName(ELEMint);
        	for(int i=0; i<intEle.getLength(); i++){
        		Element ele = (Element) intEle.item(i);
        		String valueString = ele.getAttribute(ATTRvalue);
        		try{
        			Integer.parseInt(valueString);
        		}catch(NumberFormatException e){
        			System.out.println( "-Error: Int element contains non-numberic arguement: value=\""+valueString+"\"----" );
        			throw new NumberFormatException("non-numberic arguement exception");
        		}
        	}
        	
        	System.out.println("------------calculation begin------------");
	        //normalise elements
	        testDoc.getDocumentElement().normalize();
	        
	        //root node 
	        Node root = testDoc.getDocumentElement();
	        
	        result = this.nodeResult(root);
	        
	        //System.out.println("Experssion: "+expression);
	        System.out.println("Result = "+result);
	        System.out.println("-----------calculation end---------------");
	        // TODO: Compute result
	        System.out.println("    .... computed result");
        }else{ //testfile validate fail against Scheme
        	 System.out.println("testfile is invalid against Scheme");
        	 
        }
        return result; // TODO: Return result or throw exception
    }
    
    private int nodeResult(Node node){
    	
    	int result = 0;
    	String expName = node.getLocalName();
    	//list of all number of child Node
    	List<Integer> intList = new ArrayList<Integer>();
        //list of expression of child node
    	
    	//childern nodes
        NodeList childList = node.getChildNodes();
        
        //recursion, go to the deepest "int" elements, calculate and return the parent node 
        for (int i=0; i<childList.getLength(); i++){
        	//childe node
        	Node child = childList.item(i);
        	if(child.getLocalName()!=null){

	    		if(child.getLocalName().equals(ELEMint)){ //int element
            		Element tempE = (Element) child;
            		int value = Integer.parseInt( tempE.getAttribute(ATTRvalue) );
            		intList.add(value);
	    		}else{
	    			// not int element, has children then go deeper
	    			int childResult = nodeResult(child);
	    			intList.add(childResult);
	    		}
	    		
        	}
        }
        
        //subexpression 
        //calculate resutlt in this node
        if(expName.equals(ELEMplus)){	
        	for(Integer tp : intList){
        		result += tp;
        	}
        }else if(expName.equals(ELEMtimes)){
        	result = 1;
        	for(Integer tp : intList){
        		result = result * tp;
        	}
        }else if(expName.equals(ELEMminus)){ // only two Interger in a minus express
        	result = intList.get(0) - intList.get(1);
        }else if(expName.equals(ELEMexpr)){
        	result = intList.get(0);
        }
    	return result;
    }
}
