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
		execl("./pluspp.out","./pluspp.out",NULL);
	}
	close(fdmc[0]);
	close(fdcm[1]);
	fclose(stdin);
	fclose(stdout);
	stdin=fdopen(fdcm[0],"r");
	stdout=fdopen(fdmc[1],"w");
	setvbuf(stdin,NULL,_IONBF,0);
	setvbuf(stdout,NULL,_IONBF,0);
	sleep(1);
	printf("%i %i\n",3,5);
	printf("%i %i\n",7,8);
	printf("%i %i\n",-1,2);
	printf("%i %i\n",2,4);
	char s[1024];
	while(fgets(s,1024,stdin))
		fprintf(stderr,": %s",s);
	return 0;
}
