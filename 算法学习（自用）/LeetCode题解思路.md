# 1. 100-1 两数之和

![1646741816338](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1646741816338.png)



思路：
暴力解法：双重循环定1动1得到结果 O(n**2)

优化解法：利用unordered_map构造hashmap将内层循环的复杂度变为O(1)

```c++
vector<int> twoSum(vector<int>& nums, int target) {
        //需要注意使用的是unordered map
        unordered_map<int, int> hashmap;
        for(int i=0;i<nums.size();i++)
        {
            int x = nums[i];
            auto it = hashmap.find(target-x);//auto自动类型转换
            if(it!=hashmap.end())
            {
                return {it->second, i};//返回{}类型为函数规定返回的类型
            }
            else
            {
                hashmap[x] = i;
            }
        }
        return {};
    }
```

# 2. 217-存在重复元素

![1647007652325](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1647007652325.png)

思路1：暴力法：利用二重循环进行两个数的比较，相同则返回true，遍历完毕不相同则返回false

思路2：利用set<int>的自动去重功能进行判断

```c++
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        set<int> s;
        for(auto &it:nums)
        {
            int num = s.size();
            s.insert(it);
            if(num==s.size())
                return true;
        }
        return false;
    }
};
```

思路3：利用排序判断相邻的两个数是否相同

```c++
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        for(int i=0;i<nums.size()-1;i++)
        {
            if(nums[i]==nums[i+1])
            {
                return true;
            }
        }
        return false;
    }
};

```

思路4：利用hashmap进行重复的判断

```c++
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        map<int, int> m;
        for(auto &it:nums)
        {
            if(m.find(it)==m.end())
            {
                m[it] = 1;
            }
            else
            {
                m[it]++;
                if(m[it]>=2)
                {
                    return true;
                }
            }
        }
        return false;
    }
};
```

总结：巧妙利用数据结构的特性进行数据的操作

# 3. 53-最大子数组和

![1647008236815](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1647008236815.png)

这里注意到子数组是求连续最大和

思路1：贪心双指针法

贪心——考虑到最大和，我们不希望引入负数，但是为了保证连续且最大，所以如果当前数字加入不使得sum变为负数则可以加入，否则舍弃，重新计数

这里需要考虑最终结果为负数的情况，所以需要利用flag进行判断，能否找到第一个正数

```c++
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = -INT_MAX;
        int flag = 0;
        int sum = -INT_MAX;
        for(auto &i:nums)
        {
            //寻找第一个正数，否则在负数中找最大
            if(flag==0)
            {
                if(i>=0)
                {
                    sum = 0;
                    sum += i;
                    flag = 1;
                }
                else
                    ans = max(i, ans);
                continue;
            }
            ans = max(sum, ans);
            //正数则直接加上
            if(i>=0)
                sum+=i;
            else//否则判断是否使sum小于0，不小于则加上，否则重新算
            {
                if(sum+i<=0)
                    sum = 0;
                else
                    sum += i;
            }
        }
        ans = max(sum, ans);
        return ans;
    }
}
```

思路2：动态规划

连续子序列

定义子问题——定义状态

对于[1, 2, -2, 3]:

子问题1：含1的连续子数组最大和是多少？

子问题2：含2的连续子数组最大和是多少？

子问题3：含-2的连续子数组最大和是多少？

子问题4：含3的连续子数组最大和是多少？

**注意到子问题可能会有交集，我们需要对子问题进行细化：**

子问题1：结尾为1的连续子数组最大和是多少？

子问题2：结尾为2的连续子数组最大和是多少？

子问题3：结尾为-2的连续子数组最大和是多少？

子问题4：结尾为3的连续子数组最大和是多少？

**则可以按照动态规划题解的方法将：状态定义、状态转移方程，初始化都写出**

arr[i]：表示nums[i]结尾的连续子数组的最大和

由于nums[i]一定会取，则我们需要判断我们是否需要前面的“最大连续前缀和”则

需要比较max{arr[i-1]+nums[i], nums[i]}

**跟贪心的想法类似，当前面的和对当前没有贡献时，则舍去仅保留当前**

则有

```c++
arr[i] = max{arr[i-1]+nums[i], nums[i]}
```

初始化：第一个数必定是以第一个数结尾，则arr[0] = nums[0]

**最后考虑到一维的数组可以进行空间优化，进行数组压缩**

仅利用一个变量来保存前一个状态即可：

```c++
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = nums[0];//初始化
        int pre = 0;
        for(auto &i:nums)
        {
            pre = max(pre+i, i);//状态转移方程
            ans = max(ans, pre);//每次需要进行最大和的判断
        }
        return ans;
    }
};
```

# 4. 2-两数相加

![1647010776946](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1647010776946.png)



思路：链表合并

简单来说就是用链表实现大数相加的步骤

首先对两个链表相同的部分进行相加

进位保留

```c++
int sum = l1->val + l2->val + jinwei
jinwei = sum/10;
p->val = sum%10;
```

**改进：**

当一个链表指针指到nullptr时，让其值变为0参与相加运算解决两数长短不一的问题

记得最后需要判断进位是否不为零进行结果的保存

**这里直接贴官方题解了——自己写的代码不够简练**

```c++
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        ListNode *head = nullptr, *tail = nullptr;
        int carry = 0;
        while (l1 || l2) {
            int n1 = l1 ? l1->val: 0;//解决长短不一的问题，短的高位补0参与运算
            int n2 = l2 ? l2->val: 0;
            int sum = n1 + n2 + carry;
            if (!head) {
                head = tail = new ListNode(sum % 10);
            } else {
                tail->next = new ListNode(sum % 10);
                tail = tail->next;
            }
            carry = sum / 10;
            if (l1) {
                l1 = l1->next;
            }
            if (l2) {
                l2 = l2->next;
            }
        }
        if (carry > 0) {//最后判断进位是否>0
            tail->next = new ListNode(carry);
        }
        return head;
    }
};
```

