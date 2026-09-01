#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>

void timeout_handler(int signum);
void execute_with_timeout(void (*func)(char fbuffer[]), int timeout_seconds, char buffer[]);
void task1(char buffer[]);
void task2(char buffer[]);
char* get_command_output(const char *cmd);
char* execute_with_timeoutGCO(char* (*func)(const char *fshcmd), int timeout_seconds, const char *shcmd);

int main() {
    while (1) {
        char *result = execute_with_timeoutGCO(get_command_output, 8, "curl -s ifconfig.me");
        execute_with_timeout(task2, 8, result);
        free(result);
        usleep(5000000);
    }
    return 0;
}

void timeout_handler(int signum) {
    printf("timeout\n");
    main();
}

void execute_with_timeout(void (*func)(char fbuffer[]), int timeout_seconds, char buffer[]) {
    signal(SIGALRM, timeout_handler);
    alarm(timeout_seconds);
    func(buffer);
    alarm(0);
}

void task1(char buffer[]) {
    FILE* fp = popen("/bin/curl -s ifconfig.me", "r");

    if (fp == NULL) {
        perror("popen fail\n");
    }
    while (fgets(buffer, sizeof(&buffer), fp) != NULL) {
        printf("%s\n", buffer);
    }
    pclose(fp);
}

void task2(char buffer[]) {
    FILE* fpw = fopen("/home/rq/.rq-scripts/eip/ip", "w");
    if (fpw == NULL) {
        printf("file not open");
    } else {
        printf("file created\n");
    }

    fprintf(fpw, "%s", buffer);
    fclose(fpw);
}

char* get_command_output(const char *cmd) {
    FILE *fp = popen(cmd, "r");

    if (fp == NULL) {
        return NULL;
    }

    char *output = NULL;
    size_t len = 0;
    size_t capacity = 256;

    output = malloc(capacity);
    if (output == NULL) {
        pclose(fp);
        return NULL;
    }

    char buffer[128];
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        size_t needed = len + strlen(buffer);
        if (needed >= capacity) {
            capacity = capacity * 2;
            char *temp = realloc(output, capacity);
            if (temp == NULL) {
                free(output);
                pclose(fp);
                return NULL;
            }
            output = temp;
        }
        strcpy(output + len, buffer);
        len = needed;
    }

    pclose(fp);
    return output;
}

char* execute_with_timeoutGCO(char* (*func)(const char *fshcmd), int timeout_seconds, const char *shcmd) {
    signal(SIGALRM, timeout_handler);
    alarm(timeout_seconds);
    return func(shcmd);
    alarm(0);
}
