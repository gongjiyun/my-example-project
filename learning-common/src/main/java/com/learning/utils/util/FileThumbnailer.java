package com.learning.utils.util;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.ImagingOpException;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.pdfbox.pdfviewer.PageDrawer;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileThumbnailer {
	
	private static final Logger logger = LoggerFactory.getLogger(FileThumbnailer.class);
	
	private static final Color TRANSPARENT_WHITE = new Color(255, 255, 255, 0);
	
	public static byte[] generateThumbnail(InputStream input) {
		
		PDDocument document = null;
		try {
			try {
				document = PDDocument.load(input);
			} catch (IOException e) {
				logger.error("Could not load PDF File", e);
				return null;
			}
			
			BufferedImage tmpImage = writeImageFirstPage(document, BufferedImage.TYPE_INT_RGB);
			
			ByteArrayOutputStream bytesOutputStream = new ByteArrayOutputStream();
			
			ImageIO.write(tmpImage, "PNG", bytesOutputStream);
			
			return bytesOutputStream.toByteArray();
			
		} catch (IOException e) {
			logger.error("Error occurred while generating thumbnail.", e);
			return null;
		} finally {
			if( document != null )	{
				try {
					document.close();
				} catch (IOException e)  {}
			}
		}
	}
	
	public static byte[] generateThumbnail(InputStream input, String extension) {
		File temp = null;
		try {
			if(extension.startsWith("\\.")){
				temp = File.createTempFile("temp"+ (Math.random()*100), extension);
			}else{
				temp = File.createTempFile("temp"+ (Math.random()*100), "." + extension);
			}
			
			FileUtils.copyInputStreamToFile(input, temp);	
			byte[] thumbnail = generateThumbnail(temp);
			return thumbnail;
		} catch (IOException e) {
			logger.error("Error occurred while generating thumbnail.", e);
			return null;
		} finally {
			if(temp!=null){
				FileUtils.deleteQuietly(temp);
			}
		}
	}
	
	public static byte[] generateThumbnail(File input) {
		try {
			checkFile(input);
		} catch (Exception e) {
			logger.error("The input file is invalid.", e);
			return null;
		}
		
		ByteArrayOutputStream bytesOutputStream = new ByteArrayOutputStream();
		
		String fileExtension = FileUtil.getExtension(input.getName()).toUpperCase();
		
		switch (fileExtension) {
		
		case "PDF": {
			PDDocument document = null;
			try {
				try {
					document = PDDocument.load(input);
				} catch (IOException e) {
					logger.error("Could not load PDF File", e);
					return null;
				}

				BufferedImage tmpImage = writeImageFirstPage(document, BufferedImage.TYPE_INT_RGB);
				
				ImageIO.write(tmpImage, "jpeg", bytesOutputStream);
				
				return bytesOutputStream.toByteArray();
				
			} catch (IOException e) {
				logger.error("Error occurred while generating thumbnail.", e);
				return null;
			} finally {
				if( document != null )	{
					try {
						document.close();
					} catch (IOException e)  {}
				}
			}
		}
		
		case "XLS": 
		case "XLSX": {
			InputStream in = FileThumbnailer.class.getResourceAsStream("/default_excel_thumbnail.jpg");
			try {
				return IOUtils.toByteArray(in);
			} catch (IOException e) {
				logger.error("Error occurred while getting thumbnail of MS-Excel file.", e);
				return null;
			}
		}
		
		case "DOC":
		case "DOCX": {
			InputStream in = FileThumbnailer.class.getResourceAsStream("/default_word_thumbnail.jpg");
			try {
				return IOUtils.toByteArray(in);
			} catch (IOException e) {
				logger.error("Error occurred while getting thumbnail of MS-Word file.", e);
				return null;
			}
		}
		
		case "PNG":
		case "JPG":
		case "JPEG": {
			InputStream in = FileThumbnailer.class.getResourceAsStream("/default_photo_thumbnail.jpg");
			try {
				return IOUtils.toByteArray(in);
			} catch (IOException e) {
				logger.error("Error occurred while getting thumbnail of photo.", e);
				return null;
			}
		}
		
		default: {
			InputStream in = FileThumbnailer.class.getResourceAsStream("/default_file_thumbnail.jpg");
			try {
				return IOUtils.toByteArray(in);
			} catch (IOException e) {
				logger.error("Error occurred while getting thumbnail of file.", e);
				return null;
			}
		}
		}
	}
	
	private static BufferedImage writeImageFirstPage(PDDocument document, int imageType) 
			throws IOException {
		
		List<?> pages = document.getDocumentCatalog().getAllPages();
		PDPage page = (PDPage)pages.get(0);
		
		BufferedImage image = convertToImage(page, imageType);
//		BufferedImage image = page.convertToImage();
		
		return image;
	}
	
	private static BufferedImage convertToImage(PDPage page, int imageType) 
			throws IOException {
		
		PDRectangle mBox = page.findMediaBox();
		float widthPt = mBox.getWidth();
        float heightPt = mBox.getHeight();
        
        Dimension pageDimension = mBox.createDimension();
        
        BufferedImage retval = new BufferedImage((int) widthPt, (int) heightPt, imageType);
        Graphics2D graphics = (Graphics2D)retval.getGraphics();
        graphics.setBackground(TRANSPARENT_WHITE);
        graphics.clearRect(0, 0, retval.getWidth(), retval.getHeight());
        
        PageDrawer drawer = new PageDrawer();
        drawer.drawPage(graphics, page, pageDimension);
        
        try
        {
          int rotation = page.findRotation();
          if ((rotation == 90) || (rotation == 270))
          {
            int w = retval.getWidth();
            int h = retval.getHeight();
            BufferedImage rotatedImg = new BufferedImage(w, h, retval.getType());
            Graphics2D g = rotatedImg.createGraphics();
            g.rotate(Math.toRadians(rotation), w / 2, h / 2);
            g.drawImage(retval, null, 0, 0);
          }
        }
        catch (ImagingOpException e)
        {
          logger.warn("Unable to rotate page image", e);
        }

        return retval;
	}
	
	private static void checkFile(File file) throws Exception {
		if (null == file || !file.exists()) {
			logger.error("The file does not exist.");
			throw new Exception("The file does not exist.");
		} else if (!file.isFile() && !file.isDirectory()) {
			logger.error("It's not a file or directory: " + file.getAbsolutePath());
			throw new Exception("It's not a file or directory: " + file.getAbsolutePath());
		} else if (!file.canRead()) {
			logger.error("The file cannot be read: " + file.getAbsolutePath());
			throw new Exception("The file cannot be read: " + file.getAbsolutePath());
		} else if (file.length() == 0) {
			logger.error("The file is empty: " + file.getAbsolutePath());
			throw new Exception("The file is empty: " + file.getAbsolutePath());
		}
	}

}
