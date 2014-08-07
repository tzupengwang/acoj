/*
 * ACOJ Judge Client
 * ./main.cpp
 * Version: 2014-05-12
 * Author: An-Li Alt Ting
 * Email: anlialtting@gmail.com
 */
#include<unistd.h>
#include<cstdio>
using namespace std;
#include"debug.hpp"
#include"function.hpp"
#include"const.hpp"
#include"struct.hpp"
#include"config.hpp"
#include"judge.hpp"
#include"io_mysql.hpp"
verdict_s::verdict_s(
		submission_s&submission,
		vector<testdata_s>testdatas,
		rater_s&rater
		){
	const int max_path=1<<10;
	const int max_command=1<<10;
	// prepare the rater
	{
		char path_rater_source[max_path];
		sprintf(path_rater_source,"%srater.cpp",config.path_testarea.c_str());
		// save the source code of rater into file
		FILE*file_rater_source=fopen(path_rater_source,"w");
		fputs(rater.sourcecode,file_rater_source);
		fclose(file_rater_source);
		// compile the rater
		int pid_child=fork();
		if(!pid_child){
			system("g++ -o ./testarea/rater.out ./testarea/rater.cpp");
			exit(EXIT_SUCCESS);
		}
		waitpid(pid_child,0,0);
		remove(path_rater_source);
	}
	// compile, break if error
	compilation=compilation_result_s(submission);
	if(compilation.error)
		return;
	// for each testdata, do test
	printf("ID(SUB)\tID(TD)\tTIM(ms)\tMEM(KiB)\tRESULT\tRATING\n");
	for(auto&testdata:testdatas){
		if(submission.language==6){
			testdata.limit_memory+=1048576;
			testdata.limit_stack+=1048576*1024;
		}
		feedbacks[testdata.id]=feedback_s(submission,testdata,rater);
		printf("%7i\t%7i\t%7i\t%7i\t\t%s\t%f\n",
				submission.id,
				testdata.id,
				feedbacks[testdata.id].execution.usage_time_ms,
				feedbacks[testdata.id].execution.usage_memory_kib,
				name_status_short[result_to_status[
				feedbacks[testdata.id].execution.result]],
				feedbacks[testdata.id].rating
		      );
		database.update_feedback(
				submission,
				testdata.id,
				feedbacks[testdata.id]);
	}
	// remove the binary file.
	char path_execute[max_path];
	char path_rater[max_path];
	sprintf(path_execute,"%smain.out",config.path_testarea.c_str());
	remove(path_execute);
	sprintf(path_rater,"%srater.out",config.path_testarea.c_str());
	remove(path_rater);
}
void prepare_and_judge(submission_s&submission){
#ifdef ACOJ_DEBUG
	fprintf(stderr,"submission %i:\n",submission.id);
#endif
	// prepare problem
	problem_s problem=database.select_problem(submission);
	// prepare testdata
	vector<testdata_s>testdatas=database.select_testdata(problem);
	// prepare rater
	rater_s rater=database.select_rater(problem);
	// judge
	verdict_s verdict(submission,testdatas,rater);
	// update
	database.update_verdict(submission,verdict);
}
void wait_submissions(int&previous_state,int&state){
	int t=(int)time(0),seconds=t%60,minutes=(t/=60)%60,hours=(t/=60)%24;
	submission_s submission;
	if(database.select_submission(submission)){
		state=1;
		if(previous_state!=state)
			printf("\n\n");
		printf("%02i:%02i:%02i submission got.\n"
				,(hours+8)%24,minutes,seconds);
		fflush(stdout);
		prepare_and_judge(submission);
		printf("\n");
	}else{
		state=2;
		if(previous_state==state)
			printf("\r");
		printf("%02i:%02i:%02i waiting for submissions ..."
				,(hours+8)%24,minutes,seconds);
		fflush(stdout);
	}
}
int main(int argc,char*argv[]){
#ifdef ACOJ_DEBUG
	freopen("./error.log","a",stderr);
#endif
	static const int waiting_time=(int)1e5;
	nice(-15);	// adjustment: -15
	config.load();
	config.ensure_paths_exist();
	int previous_state=2;
	while(1){
		int state=0;
		// selecting
		database.init();
		if(database.open()){
			wait_submissions(previous_state,state);
		}
		database.close();
		// selecting done
		// sleep if waiting
		if(state==2)
			usleep(waiting_time);
		previous_state=state;
	}
	return EXIT_SUCCESS;
}
