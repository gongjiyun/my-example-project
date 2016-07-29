package mytest.basic;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class TestZip {
	private int k = 1;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TestZip book = new TestZip();
		try {
			book.zip("C:/apps/Oracle.zip",
					new File("C:/apps/Oracle"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void zip(String zipFileName, File inputFile) throws Exception {
		System.out.println("start...");
		ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
				zipFileName));
		BufferedOutputStream bo = new BufferedOutputStream(out);
		System.out.println("input file > " + inputFile.getName());
		zip(out, inputFile, inputFile.getName(), bo);
		bo.close();
		out.close();
		System.out.println("finshed");
	}

	private void zip(ZipOutputStream out, File f, String base,
			BufferedOutputStream bo) throws Exception {
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			if (fl.length == 0) {
				out.putNextEntry(new ZipEntry(base + "/"));
				System.out.println(base + "/");
			}
			for (int i = 0; i < fl.length; i++) {
				zip(out, fl[i], base + "/" + fl[i].getName(), bo);
			}
			System.out.println("the times " + k + " .");
			k++;
		} else {
			out.putNextEntry(new ZipEntry(base));
			System.out.println(base);
			FileInputStream in = new FileInputStream(f);
			BufferedInputStream bi = new BufferedInputStream(in);
			int b;
			while ((b = bi.read()) != -1) {
				bo.write(b);
			}
			bi.close();
			in.close();
		}
	}

}
