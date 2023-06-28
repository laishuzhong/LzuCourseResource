# 1. CSP2021-09-2非零段划分

![1646740982587](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1646740982587.png)

思路：差分法+前缀和

岛屿情况来分析，所有数被海水淹没，只有0个岛屿，海平面逐渐下降，岛屿数量发生变化，每一个凸峰出现，则岛屿+1，每一个凹谷出现，原本相邻的岛屿就被连在一起，岛屿数-1。

需要使用unique来去除相邻重复的元素

可以得到以下结论：

当前的数需要变为0，左右两边的数都大于当前的数，则分段+1

当前的数需要变为0，左右两边的数都小于当前的数，则分段-1

其余情况分段不变

```cpp
/* CCF202109-2 非零段划分 */

#include <bits/stdc++.h>

using namespace std;

const int N = 500000;
const int M = 10000;
int a[N + 2], d[M + 1];

int main()
{
    int n;
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) scanf("%d", &a[i]);
    a[0] = a[n + 1] = 0;

    n = unique(a, a + n + 2) - a - 1;

    memset(d, 0, sizeof d);
    for (int i = 1; i < n; i++)
        if (a[i - 1] < a[i] && a[i] > a[i + 1]) d[a[i]]++;
        else if (a[i - 1] > a[i] && a[i] <a[i + 1]) d[a[i]]--;

    int ans = 0, sum = 0;   // 差分前缀和即为答案
    for (int i = M; i >= 1; i--)
        sum += d[i], ans = max(ans, sum);

    printf("%d\n", ans);

    return 0;
}

```

# 2. CSP2020-12-2最佳阈值

![1646741566663](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1646741566663.png)

思路：排序+前缀

通过记录y对应左边的0的个数和右边的1的个数来得到阈值为i时预测准确的数量

在最后计算时，相同的y值只算第一次出现的

前缀和计算0，后缀和计算1

```cpp
//满分做法——前缀和+排序
struct stu
{
    int y;
    int result;
    int left;
    int right;
};
bool cmp(stu a , stu b)
{
    if(a.y!=b.y)
        return a.y < b.y;
    else
        return a.result < b.result;
}
int main()
{
    int m;
    scanf("%d", &m);
    stu s[m+2];
    s[0].y = -1;
    s[0].result = 0;
    for(int i=1;i<=m;i++)
    {
        scanf("%d %d", &s[i].y, &s[i].result);
    }
    sort(s+1, s+m+1, cmp);
    s[0].left = 0;
    //统计左边的0
    for(int i=1;i<=m;i++)
    {
        s[i].left = s[i-1].left;
        if(s[i-1].result==0)
        {
            s[i].left++;
        }
    }
    //统计右边的1
    s[m+1].right=0;
    for(int i=m;i>=1;i--)
    {
        s[i].right = s[i+1].right;
        if(s[i].result==1)
        {
            s[i].right++;
        }
    }
    int ans = 0;
    int cnt = 0;
    for(int i=m;i>=1;i--)
    {
        int t = s[i].y;
        if(t==s[i-1].y)continue;
        int temp = s[i].left + s[i].right;
        if(temp>cnt)
        {
            cnt = temp;
            ans = t;
        }
    }
    printf("%d", ans);
    return 0;
}
```



# 3. CSP2021-04-2邻域均值

![1647006688980](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1647006688980.png)

思路：

二维前缀和

```
通过a[i][j] += a[i][j-1]计算每行的前缀和
通过a[i][j] += a[i-1][j]计算每列的前缀和
```

![1647006796222](C:\Users\Eddie\AppData\Roaming\Typora\typora-user-images\1647006796222.png)

用a,b,c,d表达从0，0开始到该单元的所有元素之和

则所求的邻域之和可表示为

a-b-c-d+2b = a+b-c-d

通过左上角和右下角的row1 col1 row2 col2进行邻域矩阵的范围判断

```cpp
#include <bits/stdc++.h>
using namespace std;

//20210402邻域均值
//二维前缀和
int main()
{
    int n, L, r, t;
    int ans = 0;
    scanf("%d %d %d %d", &n, &L, &r, &t);
    int arr[601][601];
    memset(arr, 0, sizeof(arr));
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            scanf("%d", &arr[i][j]);
    //一维前缀和 行
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            arr[i][j] += arr[i][j-1];
    
    //二维前缀和 列
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            arr[i][j] += arr[i-1][j];
    
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=n;j++)
        {
            //边界确定
            int row1 = min(i+r, n);
            int col1 = min(j+r, n);
            int row2 = max(i-r-1, 0);
            int col2 = max(j-r-1, 0);
            int sum = arr[row1][col1] + arr[row2][col2] - arr[row1][col2] - arr[row2][col1];
            double avg = sum * 1.0/((row1-row2)*(col1-col2));
            if(avg<=t)
                ans++;
        }
    }
    printf("%d",ans);
    return 0;
}
```

