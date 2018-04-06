package com.learning.utils.util;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.springframework.security.crypto.codec.Base64;

public class PasswordEncoder{
	private final static String PUB_KEY = "6B@nk1ng";
	public static void main(String[] args) throws Exception {
		String test =  encrypt("testuser1;9AEEFC0ECAEBEB32F470649E97A04150;20151027145354903");
		System.out.println(test);
		String test2 = decrypt(test);
		System.out.println(test2);
	}
	
    public static String encrypt(String content) throws Exception {  
        return aesEncrypt(content, PUB_KEY);  
    }  
    
    public static String decrypt(String content) throws Exception {  
        return aesDecrypt(content, PUB_KEY);  
    }  
	
    /** 
     * base 64 encode 
     * @param bytes �������byte[] 
     * @return ������base 64 code 
     */  
    private static String base64Encode(byte[] bytes){    	
        return new String(Base64.encode(bytes));  
    }  
      
    /** 
     * base 64 decode 
     * @param base64Code �������base 64 code 
     * @return ������byte[] 
     * @throws Exception 
     */  
    private static byte[] base64Decode(String base64Code) throws Exception{  
        return Base64.decode(base64Code.getBytes());
    }  

    /** 
     * AES���� 
     * @param content �����ܵ����� 
     * @param encryptKey ������Կ 
     * @return ���ܺ��byte[] 
     * @throws Exception 
     */  
    private static byte[] aesEncryptToBytes(String content, String encryptKey) throws Exception {  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        DESKeySpec  keySpec = new DESKeySpec(encryptKey.getBytes());
        Key key = keyFactory.generateSecret(keySpec);
  
        Cipher cipher = Cipher.getInstance("DES");  
        cipher.init(Cipher.ENCRYPT_MODE, key);  
          
        return cipher.doFinal(content.getBytes("utf-8"));  
    }  
      
    /** 
     * AES����Ϊbase 64 code 
     * @param content �����ܵ����� 
     * @param encryptKey ������Կ 
     * @return ���ܺ��base 64 code 
     * @throws Exception 
     */  
    private static String aesEncrypt(String content, String encryptKey) throws Exception {  
        return base64Encode(aesEncryptToBytes(content, encryptKey));  
    }
      
    /** 
     * AES���� 
     * @param encryptBytes �����ܵ�byte[] 
     * @param decryptKey ������Կ 
     * @return ���ܺ��String 
     * @throws Exception 
     */  
    private static String aesDecryptByBytes(byte[] encryptBytes, String decryptKey) throws Exception {        
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        DESKeySpec  keySpec = new DESKeySpec(decryptKey.getBytes());
        Key key = keyFactory.generateSecret(keySpec);
        
        Cipher cipher = Cipher.getInstance("DES");  
        cipher.init(Cipher.DECRYPT_MODE, key);  
        byte[] decryptBytes = cipher.doFinal(encryptBytes);  
          
        return new String(decryptBytes);  
    }  
      
    /** 
     * ��base 64 code AES���� 
     * @param encryptStr �����ܵ�base 64 code 
     * @param decryptKey ������Կ 
     * @return ���ܺ��string 
     * @throws Exception 
     */  
    private static String aesDecrypt(String encryptStr, String decryptKey) throws Exception {  
        return aesDecryptByBytes(base64Decode(encryptStr), decryptKey);  
    }  
}
