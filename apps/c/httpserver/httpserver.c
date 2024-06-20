#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>
 
int client_num=0;//当前与服务器端连接的客户端的数目
#define PORT 5556			//目标地址端口号
#define ADDR "127.0.0.1"    //目标地址IP
 
void* handle_client(void* arg){//参数与返回值都必须是void*类型（线程函数的特点）
	int len;//收到的字节数
	int* clnt_sock = (int*)arg;
	printf("a new client connected!!!!!,total %d client connected now\n",client_num);
    //向客户端发送数据
    char buff[100] = "hello I'm Server!!!\n";
    send(*clnt_sock, buff, sizeof(buff),0);
	//memset(buff,0,sizeof(buff));
	while(1){
		if((len=recv(*clnt_sock, buff, sizeof(buff),0))>0){
			if(strcmp(buff,"exit")==0){
				printf("client exit\n");
				break;
			}
			printf("receve from client:%s\n",buff);
			send(*clnt_sock, buff, sizeof(buff),0);
			memset(buff,0,sizeof(buff));
		}
		else{
			printf("client closed\n");
			break;
		}
	}
    //关闭套接字
    close(*clnt_sock);
	client_num--;
	printf("clnt_socket closed,remain total %d client connected now\n",client_num);
}

void* client(void* arg){
	int iSocketFD = 0; //socket句柄
	unsigned int iRemoteAddr = 0;
	struct sockaddr_in stRemoteAddr = {0}; //对端，即目标地址信息
	socklen_t socklen = 0;  	
	char buf[4096] = {0}; //存储接收到的数据
 
	iSocketFD = socket(AF_INET, SOCK_STREAM, 0); //建立socket
	if(0 > iSocketFD)
	{
		printf("创建socket失败!\n");
		return 0;
	}	
 
	stRemoteAddr.sin_family = AF_INET;
	stRemoteAddr.sin_port = htons(PORT);
	inet_pton(AF_INET, ADDR, &iRemoteAddr);
	stRemoteAddr.sin_addr.s_addr=iRemoteAddr;
	
	//连接方法： 传入句柄，目标地址，和大小
	if(0 > connect(iSocketFD, (void *)&stRemoteAddr, sizeof(stRemoteAddr)))
	{
		printf("连接失败！\n");
		//printf("connect failed:%d",errno);//失败时也可打印errno
	}else{
		printf("连接成功！\n");
		recv(iSocketFD, buf, sizeof(buf), 0);
		printf("Received:%s\n", buf);
	}
	
	close(iSocketFD);//关闭socket
	return NULL;
}

int main(){
	pthread_t tidp;//线程的id
 
    //创建套接字
    int serv_sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	printf("create socket success!\n");
    //将套接字和IP、端口绑定
    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));  //每个字节都用0填充
    serv_addr.sin_family = AF_INET;  //使用IPv4地址
    unsigned int tmpAddr = 0;
    inet_pton(AF_INET, ADDR, &tmpAddr);
	serv_addr.sin_addr.s_addr=tmpAddr;
    //serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1");  //具体的IP地址
    serv_addr.sin_port = htons(5556);  //端口
    bind(serv_sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
	printf("bind success!!\n");
    //进入监听状态，等待用户发起请求
    listen(serv_sock, 3);
	printf("listening......\n");
    //接收客户端请求
    struct sockaddr_in clnt_addr;
    socklen_t clnt_addr_size = sizeof(clnt_addr);
	
	pthread_t clientp;
	if(pthread_create(&clientp, NULL, client, NULL) == -1){
		printf("create client error!");
	}
	else{
		printf("create client success!");
	}
    while(1){
        int* clnt_sock = (int *)malloc(sizeof(int));
		*clnt_sock = accept(serv_sock, (struct sockaddr*)&clnt_addr, &clnt_addr_size);
		pthread_t clientp;
		
		if((pthread_create(&tidp, NULL, handle_client, (void*)clnt_sock)) == -1){//客户端来一个请求就创建一个线程
			printf("create error!\n");
		}
		else{
			printf("create success!\n");
			client_num++;
		}
		
		if(pthread_create(&clientp, NULL, client, NULL) == -1){
			printf("create client error!");
		}
		else{
			printf("create client success!");
		}
		
		
    }
	
    close(serv_sock);//关闭服务器端
    return 0;
}