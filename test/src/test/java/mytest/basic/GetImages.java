/**
This class add by Administrator
*/
package mytest.basic;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class GetImages {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		String urlstr = "http://img.ifeng.com/tres/html/pop_page.html?http://bc.ifeng.com/main/c?db=ifeng%26bid=10239,10009,2283%26cid=1630,46,1%26sid=21825%26advid=318%26camid=2387%26show=ignore%26url=http://cps.yintai.com/Websource.aspx?source=fenghuang%26subSource=sybt%26url=http://www.yintai.com/bargain/bargainhome.aspx${}http://y3.ifengimg.com/mappa/2012/06/14/6c2d600b9ba475ff1e11997b90d938ca.swf${}0";
		URL url = new URL(urlstr);
		URLConnection uc = url.openConnection();
		System.out.println(uc.getContentType());
		
		InputStream is = uc.getInputStream();
		BufferedInputStream bfin = new BufferedInputStream(is);
		//FileInputStream fin = new FileInputStream(is);
		
		File img = new File("c:/download/" + urlstr.substring(urlstr.lastIndexOf("/")));
		FileOutputStream fs = new FileOutputStream(img);
		byte[] b = new byte[1024];
		while(bfin.read(b)!=-1){
			fs.write(b, 0, b.length);
		}
		fs.flush();
		fs.close();
		is.close();
	}

}
