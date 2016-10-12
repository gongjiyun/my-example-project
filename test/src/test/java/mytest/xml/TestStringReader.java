/**
This class add by Administrator
*/
package mytest.xml;

import java.io.StringReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class TestStringReader {
	
	public static void main(String[] args) throws Exception {
		DocumentBuilderFactory fac = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = fac.newDocumentBuilder();
		String str ="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" +
				    "<testXML>"+
					"<age type=\"ss\">test</age>" +
					"<name>100</name>"+
					"</testXML>";
		Document doc = db.parse(new InputSource(new StringReader(str)));
		Node nodes = doc.getFirstChild();
		node(nodes);
	}
	
	private static void node(Node node){
		if(node!=null){
			
			NodeList nodes0 = node.getChildNodes();
			for(int j=0;j<nodes0.getLength();j++){
				Node node0 = nodes0.item(j);
				node(node0);
			}
			if(node.getNodeName()=="#text"){
				System.out.println(node.getNodeName() + "|" + node.getNodeValue());
			}
			System.out.println(node.getNodeName() + "|" + node.getNodeValue());
			NamedNodeMap attrs = node.getAttributes();
			if(attrs!=null){
				Node arrnode = attrs.getNamedItem("type");
				if(arrnode!=null){
					System.out.println(arrnode.getNodeName());
				}
				
			}
		}
	}
	
}
