#include<cstdio>
#include<errno.h>
#include<unistd.h>
#include<iostream>
using namespace std;
int main(){
	int fd_mc[2];
	int fd_cm[2];
	pipe(fd_mc);
	pipe(fd_cm);
	int pid=fork();
	if(pid){
		close(fd_mc[0]);
		close(fd_cm[1]);
		FILE*in=fdopen(fd_cm[0],"r");
		FILE*out=fdopen(fd_mc[1],"w");
		{
			fprintf(out,"3 5\n");
			fprintf(out,"7 8\n");
			fflush(out);
			char str[128];
			for(int i=0;i<2;i++){
				char*r=fgets(str,128,in);
				if(r)
					printf("recieved: %s",str);
			}
		}
		fclose(in);
		fclose(out);
		return 0;
	}else{
		close(fd_mc[1]);
		close(fd_cm[0]);
		fclose(stdin);
		fclose(stdout);
		stdin=fdopen(fd_mc[0],"r");
		stdout=fdopen(fd_cm[1],"w");
		int a,b;
		while(scanf("%i%i",&a,&b)!=EOF){
			printf("%i+%i=%i\n",a,b,a+b);
			fflush(stdout);
		}
		return 0;
	}
	return 0;
}
