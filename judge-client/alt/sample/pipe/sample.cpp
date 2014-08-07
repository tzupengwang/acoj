#include<cstdio>
int main(){
	int f=0,l=1<<10;
	while(f!=l){
		int m=(f+l)/2;
		printf("%i\n",m);
		int v;
		scanf("%i",&v);
		if(v)
			f=m;
		else
			l=m+1;
	}
	return 0;
}
