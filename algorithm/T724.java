public class T724 {
	public int privotIndex(int[] nums) {
		int sum = 0;
		for (int i : nums) {
			sum += i;
		}

		int pre = 0;
		for (int i = 0; i < nums.length; i++) {
			if (sum - nums[i] == pre * 2)
				return i;
			else
				pre += nums[i];
		}
		return -1;
	}

	public void traverse(int[] nums) {
		for (int i : nums)
			System.out.print(i + " ");
		System.out.println();
	}

	public static void test() {
		int t1[] = {1,3,7,6,5,6};
		T724 t = new T724();
		
		t.traverse(t1);
		System.out.println("index: " + t.privotIndex(t1));
	}

	public static void main(String[] args) {
		System.out.println("T724 Find Privot Index......");
		test();
	}
}
