#include<cstdio>
#include<cstdlib>
#include<ctime>
int main(int argc,char*argv[]){
	setvbuf(stdout,NULL,_IONBF,0);
	FILE*testdata_input=fopen(argv[1],"r");
	FILE*rate_output=fopen(argv[4],"w");
	int rate=1024,x;
	fscanf(testdata_input,"%i",&x);
	while(1){
		int n;
		if(scanf("%i",&n)!=1){
			rate=0;
			break;
		}
		printf("%i\n",n<x);
		rate--;
		if(n==x)
			break;
	}
	fprintf(rate_output,"%i\n",rate);
	return EXIT_SUCCESS;
}

