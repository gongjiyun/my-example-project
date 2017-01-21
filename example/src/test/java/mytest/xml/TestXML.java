package mytest.xml;

import java.io.StringReader;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

//@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class TestXML {
	private String name;
	private String age;
	
	@XmlElementWrapper(name="emails")
	@XmlElement(name="email")
	private List<String> emails;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public static void main(String[] args) throws Exception {
		String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><testXML><age type=\"   d  \"/><name>test</name></testXML>";
		JAXBContext jc = JAXBContext.newInstance(new Class[]{TestXML.class});
		
		Unmarshaller u = jc.createUnmarshaller();
		TestXML fooObj = (TestXML)u.unmarshal( new StringReader(xml));
		System.out.println(fooObj.getName());
		System.out.println(fooObj.getAge());
		System.out.println(fooObj.emails);
		/*TestXML vo = new TestXML();
		vo.setName("100");
		vo.setAge("test");
		
		List emails = new ArrayList();
		emails.add("good@gmail.com");
		emails.add("jiyun@hotmail.com");
		 
		vo.emails = emails;
		File file = new File("c:test.xml");
		if(!file.exists()){
			file.createNewFile();
		}
		PrintWriter pw = new PrintWriter(file);
		
		Marshaller marsh = jc.createMarshaller();
		marsh.marshal(vo, pw);*/
	}
}
