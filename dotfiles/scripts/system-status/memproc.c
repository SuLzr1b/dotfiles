#include <stdio.h>
#include <math.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

char* task1(const char *cmd);
long ctokcon(char* token, int loops);
void task2(int memUsage, long usageMem, long totalMem);

int main() {
    while (1) {
        char* resultmem = task1("free | grep Mem");
        printf("%s\n", resultmem);

        char* token = strtok(resultmem, " ");
        long totalMem = ctokcon(token, 1);
        long utilMem = ctokcon(token, 1);

        printf("totalMem: %ld\n", totalMem);
        printf("utilMem: %ld\n", utilMem);

        free(token);

        int memUsage = round(100 * utilMem / totalMem);
        printf("usageMem: %d%%\n", memUsage);
        task2(memUsage, utilMem, totalMem);
        usleep(5000000);
    }
    return 0;
}

void task2(int memUsage, long usageMem, long totalMem) {
    double gbusage = usageMem;
    double gbtotal = totalMem;

    double usage = gbusage / 1048576;
    double total = gbtotal / 1048576;
    FILE* fpw = fopen("/home/rq/.rq-scripts/system-status/mem", "w");
    if (fpw == NULL) {
        perror("fpw failed");
    }
    fprintf(fpw, "%d%% (%.2lf / %.2lf)", memUsage, usage, total);
    printf("%d%% (%.2lf / %.2lf)\n", memUsage, usage, total);
    fclose(fpw);
}

long ctokcon(char* tokenfun, int loops) {
    char* token = tokenfun;
    char* endptr;
    for (int i = 0; i < loops; i++) {
        token = strtok(NULL, " ");
    }
    long value = strtol(token, &endptr, 10);
    return value;
}

char* task1(const char *cmd) {
    FILE *fp = popen(cmd, "r");

    if (fp == NULL) {
        perror("popen error\n");
        return NULL;
    }

    char* output = NULL;
    size_t capacity = 256;
    output = malloc(capacity);
    if (output == NULL) {
        perror("output NULL");
        pclose(fp);
        return NULL;
    }

    char buffer[128];
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        strcpy(output, buffer);
    }
    pclose(fp);

    return output;
}
