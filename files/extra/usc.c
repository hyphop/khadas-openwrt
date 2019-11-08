
// hyphop //

// unix socket read write by cmd line 

#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

//char *socket_path = "./socket";
char *socket_path = "\0hidden";

int main(int argc, char *argv[]) {
  struct sockaddr_un addr;
  char buf[4096];
  int fd,rc;

  if (argc > 1) socket_path=argv[1];

  if ( (fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
    perror("socket error");
    exit(-1);
  }

  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  if (*socket_path == '\0') {
    *addr.sun_path = '\0';
    strncpy(addr.sun_path+1, socket_path+1, sizeof(addr.sun_path)-2);
  } else {
    strncpy(addr.sun_path, socket_path, sizeof(addr.sun_path)-1);
  }

  if (connect(fd, (struct sockaddr*)&addr, sizeof(addr)) == -1) {
    perror("connect error");
    exit(-1);
  }



//  while( (rc=read(STDIN_FILENO, buf, sizeof(buf))) > 0) {
//
//	printf(">%s\n", buf );
//	
  //  if (write(fd, buf, rc) != rc) {
//      if (rc > 0) fprintf(stderr,"partial write");
  //    else {
//        perror("write error");
//        exit(-1);
//      }
//    }
//  }
    char * line = NULL;
    size_t len = 0;
    ssize_t rd;

    while ((rd = getline(&line, &len, stdin)) != -1) {
//        printf("Retrieved line of length %zu :\n", read);
		if ( *line == '<' ) {
				rc=read(fd,buf,sizeof(buf));
				printf("%s", buf);
				*line='\0';
		} else if ( *line == '[' ) {
				rc=read(fd,buf,sizeof(buf));
		} else if ( *line == '>' ) {
				line++;
			if (write(fd, line, rd-1) != rc) {
//       		 	fprintf(stderr, ">%d", rd);
			} else {
       		 	fprintf(stderr, "[E] %s\n", line);
				exit(-1);
			}
				line--;
//		} else if ( *line == '{' ) {
  //     		 printf("%d>%s", read, line);
		}
    }

  if (line)
        free(line);
  return 0;
}
