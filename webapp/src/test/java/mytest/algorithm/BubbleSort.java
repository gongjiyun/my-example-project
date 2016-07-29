/**
This class add by jiyun
 */
package mytest.algorithm;

import org.apache.commons.logging.impl.SLF4JLocationAwareLog;

public class BubbleSort implements Sort{
	public int[] sort(int[] input) {
		for (int i = 0; i < input.length; i++) {
			int temp;
			for (int j = i + 1; j < input.length; j++) {
				if (input[i] > input[j]) {
					temp = input[j];
					input[j] = input[i];
					input[i] = temp;
				}
			}
		}
		return input;
	}
}
