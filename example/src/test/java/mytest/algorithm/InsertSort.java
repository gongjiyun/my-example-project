/**
This class add by jiyun
 */
package mytest.algorithm;

public class InsertSort implements Sort{
	public int[] sort(int[] input) {
		for (int i = 1; i < input.length; i++) {
			int temp = input[i];
			for (int j = i; j > 0; j--) {
				if (input[j - 1] >= temp) {
					input[j] = input[j - 1];
					input[j - 1] = temp;
				}
			}
		}
		return input;
	}
}
