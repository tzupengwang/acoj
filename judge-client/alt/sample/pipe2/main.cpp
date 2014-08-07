#include<unistd.h>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#include<iostream>
#include<errno.h>
using namespace std;
int main(){
	int fdmc[2],fdcm[2];
	pipe(fdmc);
	pipe(fdcm);
	int pid=fork();
	if(!pid){
		close(fdmc[1]);
		close(fdcm[0]);
		close(0);dup(fdmc[0]);
		close(1);dup(fdcm[1]);
		execl("./sample.cpp.out","./sample.cpp.out",NULL);
	}
	close(fdmc[0]);
	close(fdcm[1]);
	close(0);dup(fdcm[0]);
	close(1);dup(fdmc[1]);
	execl(
			"./rater.cpp.out",
			"./rater.cpp.out",
			"./1.in",
			"./1.out",
			"./output.txt",
			"./rate.txt",
			NULL);
}
