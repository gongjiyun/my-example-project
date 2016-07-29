/**
This class add by jiyun
*/
package mytest.jaas;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class PasswordEncryptor {
    public PasswordEncryptor() {
        super();
    }

    private static final String HEX_NUMS_STR = "0123456789ABCDEF";
    private static final String Algorithm = "DESede";
    private static final byte[] keyBytes = { 0x31, 0x23, 0x5F, 0x68, (byte)0x88, 0x12, 0x41, 0x38, 0x28, 0x45, 0x79, 0x51, (byte)0xCB, (byte)0xDD, 0x55, 0x66, 0x77, 0x19, 0x74, (byte)0x98, 0x30, 0x40, 0x66, (byte)0xE2 };
    
    public static byte[] hexStringToByte(String hex) {
        int len = (hex.length() / 2);
        byte[] result = new byte[len];
        char[] hexChars = hex.toCharArray();
        for (int i = 0; i < len; i++) {
            int pos = i * 2;
            result[i] = (byte)(HEX_NUMS_STR.indexOf(hexChars[pos]) << 4 | HEX_NUMS_STR.indexOf(hexChars[pos + 1]));
        }
        return result;
    }

    public static String byteToHexString(byte[] b) {
        StringBuffer hexString = new StringBuffer();
        for (int i = 0; i < b.length; i++) {
            String hex = Integer.toHexString(b[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            hexString.append(hex.toUpperCase());
        }
        return hexString.toString();
    }

    public static String encryptPass(String src) {
        try {
            SecretKey deskey = new SecretKeySpec(keyBytes, Algorithm);
            Cipher c1 = Cipher.getInstance(Algorithm);
            c1.init(Cipher.ENCRYPT_MODE, deskey);
            return byteToHexString(c1.doFinal(src.getBytes()));
        } catch (java.security.NoSuchAlgorithmException e1) {
            e1.printStackTrace();
        } catch (javax.crypto.NoSuchPaddingException e2) {
            e2.printStackTrace();
        } catch (java.lang.Exception e3) {
            e3.printStackTrace();
        }
        return null;
    }

    public static String decryptPass(String src) {
        try {
            SecretKey deskey = new SecretKeySpec(keyBytes, Algorithm);
            Cipher c1 = Cipher.getInstance(Algorithm);
            c1.init(Cipher.DECRYPT_MODE, deskey);
            return new String(c1.doFinal(hexStringToByte(src)));
        } catch (java.security.NoSuchAlgorithmException e1) {
            e1.printStackTrace();
        } catch (javax.crypto.NoSuchPaddingException e2) {
            e2.printStackTrace();
        } catch (java.lang.Exception e3) {
            e3.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) throws Exception{
        String password = "sdfwpass";
        System.out.println("Original Password is " + password);
        String encryptPassword = PasswordEncryptor.encryptPass(password);
        System.out.println("Encrypted Password is " + encryptPassword);
        String plainPassword = PasswordEncryptor.decryptPass(encryptPassword);
        System.out.println("Plain Password is " + plainPassword);
        
        System.out.println("--------------------------");
        password = "Sdab2345";
        System.out.println("Original Password is " + password);
        encryptPassword = PasswordEncryptor.encryptPass(password);
        System.out.println("Encrypted Password is " + encryptPassword);
        plainPassword = PasswordEncryptor.decryptPass(encryptPassword);
        System.out.println("Plain Password is " + plainPassword);
    }
}