#include <bits/stdc++.h>

using namespace std;

vector<string> tests(800, "");
ofstream success;

void test_success(string command){
	string s;
	system(command.c_str());
	ifstream res;	
	res.open("result.txt", ios::in);
	vector<string> results;
	bool end = false;

	while(getline(res, s)){
		if(end)
			results.push_back(s);
		if(s.find("tests in ") != s.npos || s.find("test in ") != s.npos){
			end = true;
			results.push_back(s);
		}
	}

	for(auto i = results.begin(); i != results.end(); ++i)
		success << *i << endl;
	res.close();

}

void read_tests(int start, int end){
	ifstream ifs;
	ifs.open("test.txt", ios::in);


	success.open("success.txt", ios::out|ios::app);

	ofstream failed;
	failed.open("failed.txt", ios::out);

	int cnt = 0;
	string s;
	while(getline(ifs, s)){
		if(s.find(".py") == s.npos)
			continue;

		cnt++;
		if(cnt < start || cnt > end) continue;
		string testfilename = "/python3.11/lib/python3.11/test/" + s;
		tests[cnt] = testfilename;

		// write axbuild.mk
		ofstream ofs;
		ofs.open("./apps/c/dl/axbuild.mk", ios::out|ios::trunc);
		tests.push_back(s);
		s = "app-objs=main.o\nARGS = /python3.11/bin/python3.11,/python3.11/lib/python3.11/test/" + s;
		s += "\nENVS = \nV9P_PATH=${APP}/rootfs\n";
		ofs << s;
		ofs.close();

		string command = "make A=apps/c/dl ARCH=aarch64 V9P=y NET=y MUSL=y LOG=error SMP=4 run " + string("ARGS=/python3.11/bin/python3.11,") + testfilename + " V9P_PATH=apps/c/dl/rootfs " + "> result.txt";

		system(command.c_str());

		bool fail = false;
		bool end = false;
		vector<string> results;
		results.clear();

		ifstream res;
		res.open("result.txt", ios::in);
		//regex stdstr("Ran(.*)tests in(.*)");
		while(getline(res, s)){
			if(!fail && s.find("ERROR") != s.npos){
				failed << testfilename << endl;
				fail = true;
			}

			if(fail){
				failed << s << endl;
				continue;
			}

			if(end)
				results.push_back(s);
			if(s.find("tests in ") != s.npos || s.find("test in ") != s.npos){
			//if(regex_match(s, stdstr)){
				end = true;
				results.push_back(s);
			}
		}
		res.close();

		if(fail){
			for(auto i = results.begin(); i != results.end(); ++i)
				failed << *i << endl;
			continue;
		}

		success << testfilename << endl;
		for(auto i = results.begin(); i != results.end(); ++i)
			success << *i << endl;
		
		for(int i = 1; i < 3; ++i)
			test_success(command);
		
	}
}

int main(int argc, char* argv[]){
	int begin = 0, end = 0;
	for(int i = 0; i < strlen(argv[1]); ++i){
		begin = begin * 10 + argv[1][i] - '0';
	}
	for(int i = 0; i < strlen(argv[2]); ++i){
		end = end * 10 + argv[2][i] - '0';
	}
	//printf("%d %d\n", begin, end);
	read_tests(begin, end);
	return 0;
}