package mytest.xml;

import java.io.InputStream;

import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

public class TestXSDValidate {
	
    public static boolean validateXML(String xsdPath,String xmlData){
        SchemaFactory schemaFactory = SchemaFactory
                .newInstance("http://www.w3.org/2001/XMLSchema");

        Schema schema = null;
        try {
            InputStream is = TestXSDValidate.class.getResourceAsStream(xsdPath);
            System.out.println(is.available());
            Source source = new StreamSource(is);
            System.out.println(source);
            schema = schemaFactory.newSchema(source);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Validator validator = schema.newValidator();       

        try {
            InputStream is = TestXSDValidate.class.getResourceAsStream(xmlData);
            System.out.println(is.available());
            Source source = new StreamSource(is);
            System.out.println(source);
            validator.validate(source);
            System.out.println();
        }catch (Exception ex) {
            System.out.println(ex.getMessage());
            ex.printStackTrace();
            return false;
        }
        return true;
    }
    
    public static void main(String[] args) {
    	validateXML("TestXMLSchema.xsd", "TestXML.xml");
	}
}
