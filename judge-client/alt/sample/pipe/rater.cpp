#include<cstdio>
#include<cstdlib>
#include<ctime>
int main(int argc,char*argv[]){
	int n=rand()%1024;
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
}
