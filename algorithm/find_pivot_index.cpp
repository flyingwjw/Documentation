#include <iostream>
#include <string>

using namespace std;

class solution {
	public:
	   	int pivotIndex(int *nums, int length) {
			int suml = 0;
			int sumr = 0;
			int i = 0;
	
			for (i = 0; i < length; i++)
				sumr += nums[i];
	
			for (i = 0; i < length; i++)
			{
				suml += nums[i];
				if (suml == sumr)
					return i;
				sumr -= nums[i];
			}
			return -1;
		};
};

int main(int argc, const char **argv)
{
	class solution s;
	int i = 0;
	int t1[] = {1,7,3,6,5,6};

	for (i = 0; i < sizeof(t1)/sizeof(int); i++)
		cout << t1[i] << " ";
	cout << endl;

	cout << "index: " << s.pivotIndex(t1, sizeof(t1)/sizeof(int)) << endl;

	return 0;
}
