package com.poc.utils.util;

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
     * @param bytes 待编码的byte[] 
     * @return 编码后的base 64 code 
     */  
    private static String base64Encode(byte[] bytes){    	
        return new String(Base64.encode(bytes));  
    }  
      
    /** 
     * base 64 decode 
     * @param base64Code 待解码的base 64 code 
     * @return 解码后的byte[] 
     * @throws Exception 
     */  
    private static byte[] base64Decode(String base64Code) throws Exception{  
        return Base64.decode(base64Code.getBytes());
    }  

    /** 
     * AES加密 
     * @param content 待加密的内容 
     * @param encryptKey 加密密钥 
     * @return 加密后的byte[] 
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
     * AES加密为base 64 code 
     * @param content 待加密的内容 
     * @param encryptKey 加密密钥 
     * @return 加密后的base 64 code 
     * @throws Exception 
     */  
    private static String aesEncrypt(String content, String encryptKey) throws Exception {  
        return base64Encode(aesEncryptToBytes(content, encryptKey));  
    }
      
    /** 
     * AES解密 
     * @param encryptBytes 待解密的byte[] 
     * @param decryptKey 解密密钥 
     * @return 解密后的String 
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
     * 将base 64 code AES解密 
     * @param encryptStr 待解密的base 64 code 
     * @param decryptKey 解密密钥 
     * @return 解密后的string 
     * @throws Exception 
     */  
    private static String aesDecrypt(String encryptStr, String decryptKey) throws Exception {  
        return aesDecryptByBytes(base64Decode(encryptStr), decryptKey);  
    }  
}
