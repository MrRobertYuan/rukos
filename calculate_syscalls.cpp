#include <cstdio>
#include <cstring>
#include <string>
#include <iostream>
#include <unordered_map>
#include <algorithm>
#include <bits/stdc++.h>

using namespace std;

unordered_map<int, int> q;
unordered_map<int, int> nq;


struct Node{
	int a, b;
}a[300];

bool cmp(const Node &A, const Node &B){
	return A.a < B.a;
}

unordered_map<int, string> trans;

void prework(){
	ifstream ifs;
	ifs.open("ulib/ruxmusl/musl-1.2.3/arch/aarch64/bits/syscall.h.in", ios::in);
	string s, tmp;
	int x;
	while(ifs>>tmp>>s>>x){
		s = s.substr(5, s.length()-5);
		trans[x]=s;
	}
	ifs.close();
}

int main(){
	//freopen("result.txt", "r", stdin);
	//freopen("analyze.txt", "w", stdout);

	prework();

	freopen("results.txt", "r", stdin);
	freopen("analyze.txt", "w", stdout);

	string s;
	while(getline(cin, s)){
		int len = s.length();
		int res = s.find("Handle supervisor call ");
		if(res >= 0){
			res += 23;
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
		cout << a[i].a << " " << trans[a[i].a] << " " << a[i].b << endl;
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
		cout << a[i].a << " " << trans[a[i].a] << " " << a[i].b << endl;
	}
	
	return 0;
}