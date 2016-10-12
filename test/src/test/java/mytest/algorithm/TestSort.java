/**
This class add by jiyun
 */
package mytest.algorithm;

public class TestSort {

	public static void main(String[] args) {
		TestSort t = new TestSort();
		//t.doSort(new BubbleSort(), t.getArr());
		//t.doSort(new InsertSort(), t.getArr());
		t.doSort(new MergeSort(), t.getArr());
	}

	public void print(int[] result) {
		System.out.println("after sort : ");
		for (int i = 0; i < result.length; i++) {
			if (i == 0) {
				System.out.print(result[i]);
				continue;
			}
			System.out.print(" " + result[i]);
		}
		System.out.println("\n");
	}

	public int[] getArr() {
		int[] input = { 300, 100, 1201, 6, 1, 40, 15, 85, 12, 7 };
		return input;
	}
	
	public void doSort(Sort s, int[] arr){
		print(s.sort(arr));
	}

}
