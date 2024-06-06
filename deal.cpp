#include <cstdio>
#include <cstring>
#include <string>
#include <iostream>
#include <unordered_map>
#include <algorithm>

using namespace std;

unordered_map<int, int> q;
unordered_map<int, int> nq;

int all[100]= {7, 17, 20, 25, 29, 34, 35, 36, 38, 46, 49, 53, 56, 57, 59, 61, 
62, 63, 64, 65, 66, 71, 78, 79, 80, 93, 94, 96, 98, 112, 113, 114, 115, 130, 134, 136,
135, 160, 166, 172, 174, 175, 176, 177, 178, 198, 199, 202, 204, 208, 209, 214, 215, 
216, 220, 221, 222, 226, 233, 261, 278, 283, 424};

struct Node{
	int a, b;
}a[300];

bool cmp(const Node &A, const Node &B){
	return A.a < B.a;
}

bool judge(int x){
	for(int i = 0; i < 100; ++i){
		if(x == all[i]) return true;
	}
	return false;
}

int main(){
	//freopen("result.txt", "r", stdin);
	//freopen("analyze.txt", "w", stdout);

	freopen("syscall_analyze.txt", "r", stdin);
	freopen("syscall_result.txt", "w", stdout);

	string s;
	while(getline(cin, s)){
		int len = s.length();
		int res = s.find("supervisor call ");
		if(res >= 0){
			res += 16;
			int x = 0;
			while(res < len && s[res] >= '0' && s[res] <= '9'){
				x = x * 10 + s[res] - '0';
				res ++;
			}
			if(q.find(x) == q.end())
				q[x] = 1;
			else{
				q[x] = q[x] + 1;
			}
		}
		res = s.find("unimplemented syscall id: ");
		if(res >= 0){
			res += 26;
			int x = 0;
			while(res < len && s[res] >= '0' && s[res] <= '9'){
				x = x * 10 + s[res] - '0';
				res ++;
			}
			if(nq.find(x) == nq.end())
				nq[x] = 1;
			else{
				nq[x] = nq[x] + 1;
			}
		}

	}
	int t = 0;
	for(auto i = q.begin(); i != q.end(); ++i){
		a[t].a = (*i).first;
		a[t].b = (*i).second;
		t++;
	}
	sort(a, a+t, cmp);
	for(int i = 0; i < t; ++i){
		if(!judge(a[i].a))
			cout << a[i].a << " " << a[i].b << endl;
	}

	cout << "unimplemented syscall" << endl;

	t = 0;
	for(auto i = nq.begin(); i != nq.end(); ++i){
		a[t].a = (*i).first;
		a[t].b = (*i).second;
		t++;
	}
	sort(a, a+t, cmp);
	for(int i = 0; i < t; ++i){
		if(!judge(a[i].a))
			cout << a[i].a << " " << a[i].b << endl;
	}
	
	return 0;
}