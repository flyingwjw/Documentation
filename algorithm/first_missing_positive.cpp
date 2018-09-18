#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <stdint.h>

using namespace std;

void traverse(vector<int>& nums)
{
	for (vector<int>::iterator it = nums.begin();
			it != nums.end(); ++it)
	{
		cout << *it << ' ';
	}
//	cout << endl << "================" << endl;
	cout << endl;
}

class Solution {
	public:
		int firstMissingPositive(vector<int>& nums) {
			nums.push_back(0);
			uint32_t sz = nums.size();
			cout << "size: " << sz << endl;
			cout << "----------------" << endl;
			traverse(nums);

			for (uint32_t i = 0; i < sz; i++)
			{
				uint32_t index = i;
				int32_t value = nums[i];
				cout << endl << "++++++++++++++++" << endl;
				cout << "befor index: " << index << endl;
				cout << "befor value: " << value << endl;

				while (index != value && value >= 0 && value < sz)
				{
					cout << "replace......" << endl;
					int new_value = nums[value];
					nums[value] = value;
					index = value;
					value = new_value;
					traverse(nums);
					cout << "\tindex: " << index << endl;
					cout << "\tvalue: " << value << endl;
				}

				cout << "after index: " << index << endl;
				cout << "after value: " << value << endl;
				cout << "----------------" << endl;
				traverse(nums);
			}

			for (uint32_t i = 1; i < sz; i++)
			{
				if (nums[i] != i)
				{
					return i;
				}
			}
			return sz;
		}
};

int main(int argc, const char** argv)
{
	class Solution s;
	string line;
	getline(cin, line);
	stringstream ss(line);
	vector<int> nums;
	int num;

	while (ss >> num) {
		nums.push_back(num);
	}

	traverse(nums);
	cout << "result: " << s.firstMissingPositive(nums) << endl;
	traverse(nums);

	return 0;
}
