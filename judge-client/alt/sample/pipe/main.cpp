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
/*		setvbuf(stdin,NULL,_IONBF,0);
		setvbuf(stdout,NULL,_IONBF,0);*/
		execl("./plus.cpp.out","./plus.cpp.out",NULL);
		//execl("./sample.cpp.out","./sample.cpp.out",NULL);
	}
	close(fdmc[0]);
	close(fdcm[1]);
	fclose(stdin);
	fclose(stdout);
	stdin=fdopen(fdcm[0],"r");
	stdout=fdopen(fdmc[1],"w");
	setvbuf(stdin,NULL,_IONBF,0);
	setvbuf(stdout,NULL,_IONBF,0);
	printf("%i %i\n",3,5);
	printf("%i %i\n",7,8);
	printf("%i %i\n",-1,2);
	printf("%i %i\n",2,4);
	fflush(stdout);
	char s[1024];
	while(fgets(s,1024,stdin))
		fprintf(stderr,": %s",s);
	return 0;
	close(fdmc[0]);
	close(fdcm[1]);
	//close(0);dup(fdcm[0]);
	//close(1);dup(fdmc[1]);
	fclose(stdin);stdin=fdopen(fdcm[0],"r");
	fclose(stdout);stdout=fdopen(fdmc[1],"w");
	setvbuf(stdin,NULL,_IONBF,0);
	setvbuf(stdout,NULL,_IONBF,0);
	/*int n=rand()%1024;
	  fprintf(stderr,"n=%i\n",n);
	  int x=1024;
	  while(1){
	  int k;
	  if(scanf("%i",&k)!=1){
	  x=0;
	  break;
	  }
	  printf("%i\n",k<n);
	  x--;
	  fprintf(stderr,"k=%i\n",k);
	  if(k==n)
	  break;
	  }
	  fprintf(stderr,"x=%i\n",x);
	  return EXIT_SUCCESS;
	  execl("./rater.cpp.out","./rater.cpp.out",NULL);*/
}
