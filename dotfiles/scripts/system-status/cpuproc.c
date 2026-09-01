#include <stdio.h>
#include <math.h>
#include <signal.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

char* task1(const char *cmd);
long ctokcon(char* token, int loops);
void task2(double cpuUsage);

int main() {
    while (1) {
        char* resultcpu = task1("head -1 /proc/stat");
        printf("%s\n", resultcpu);

        char* token = strtok(resultcpu, " ");
        long cpu[8];
        long total1 = 0;
        long total2 = 0;
        long active1 = 0;
        long active2 = 0;

        for (int i = 0; i < 8; i++) {
            cpu[i] = ctokcon(token, 1);
            printf("%ld\n", cpu[i]);
            total1 += cpu[i];
        }
        active1 = total1 - cpu[3] - cpu[4];
        printf("cpu4 %ld\n", cpu[4]);

        usleep(1000000);

        char* resultcpu2 = task1("head -1 /proc/stat");
        char* token2 = strtok(resultcpu2, " ");

        for (int i = 0; i < 8; i++) {
            cpu[i] = ctokcon(token2, 1);
            printf("%ld\n", cpu[i]);
            total2 += cpu[i];
        }
        active2 = total2 - cpu[3] - cpu[4];

        double delta_total = total2 - total1;
        double delta_active = active2 - active1;
        double cpu_usage = (delta_active / delta_total) * 100;

        printf("cpu_usage %lf\n", cpu_usage);

        if (delta_total != 0) {
            task2(cpu_usage);
        }

        usleep(5000000);
        free(token);
        free(token2);
    }
    return 0;
}

void task2(double cpuUsage) {
    FILE* fpw = fopen("/home/rq/.rq-scripts/system-status/cpu", "w");
    if (fpw == NULL) {
        perror("fpw failed");
    }
    fprintf(fpw, "%.1lf%%", cpuUsage);
    printf("%lf%%\n", cpuUsage);
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
