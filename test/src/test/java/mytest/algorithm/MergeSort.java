/**
This class add by jiyun
 */
package mytest.algorithm;

public class MergeSort implements Sort {
	public int[] sort(int[] input) {
		return mergeSort(input);
	}

	private int[] split(int[] arr, int start, int end) {
		int[] newarr = null;
		if(end >= start){
			newarr = new int[end - start + 1];
			for (int i = 0; i<(end - start + 1); i++) {
				newarr[i] = arr[start+i];
			}			
		}
		return newarr;
	}
	
	private int[] mergeSort(int[] input) {
		if(input.length == 1){
			return input;
		}
		print(input, "before slpit");
		int[] left = split(input, 0, (input.length/2) - 1);
		int[] right = split(input, input.length/2, input.length - 1);
		print(left, "left split");
		print(right, "right split");
		left = mergeSort(left);
		right = mergeSort(right);
		return merge(left, right);
	}
	
	private int[] merge(int[] left, int[] right) {
		print(left,"left");
		print(right,"right");
		int[] temparr = new int[left.length + right.length];
		int templeft=0;
		int tempright=0;
		int temp = 0;
		while(templeft < left.length && tempright < right.length){
			if(left[templeft] > right[tempright]){
				temparr[temp++] = right[tempright++];
			}else{
				temparr[temp++] = left[templeft++];
			}
		}
		//put the leave array;
		while(templeft < left.length){
			temparr[temp++] = left[templeft++];
		}
		while(tempright < right.length){
			temparr[temp++] = right[tempright++];
		}
		print(temparr,"after merge");
		return temparr;
	}
	
	public void print(int[] input, String message){
		System.out.println("########" + message + "#########");
		for(int i : input){
			System.out.print(i + " ");
		}
		System.out.println("\n");
	}
}
