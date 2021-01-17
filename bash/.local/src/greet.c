#include <stdio.h>
#include <stdlib.h>
#include <sys/param.h>
#include <sys/utsname.h>
#include <time.h>
#include <unistd.h>


#define MAX_DATE_LEN    32
const char * const PROGNAME = "greet";

const char KERNEL[] = { 0360, 0237, 0214, 0275, 0 };
const char USER[] = {
    0xF0, 0x9F, 0x99, 0x8B, 0xF0, 0x9F, 0x8F, 0xBB, 0xE2, 0x80, 0x8D, 0xE2,
    0x99, 0x82, 0xEF, 0xB8, 0x8F, 0 };
const char SHELL[] = { 0360, 0237, 0220, 0232, 0 };
const char CALENDAR[] = { 0360, 0237, 0227, 0223, 0040, 0 };

const char *CGREEN = "\x1B[32m";
const char *CGREY = "\x1B[30;1m";
const char *CRESET = "\x1B[0m";


static void maybe_die(int code)
{
    if (code < 0) {
        perror(PROGNAME);
        exit(1);
    }
}


int main(int argc, char **argv)
{
    struct utsname sys;
    struct tm *tm;
    char *shell = getenv("SHELL");
    char *username = getenv("USER");
    char date[MAX_DATE_LEN];
    time_t t = 0;
    int res = -1;

    res = uname(&sys);
    maybe_die(res);

    t = time(NULL);
    tm = localtime(&t);
    strftime(date, MAX_DATE_LEN, "%+", tm);

    printf("%s    %s%s%s%s@%s%s\n"
           "%s    %s%s %s%s\n"
           "%s    %s%s%s\n"
           "%s    %s%s%s\n",
           USER, CGREEN, username, CRESET, CGREY, sys.nodename, CRESET,
           KERNEL, CGREY, sys.sysname, sys.release, CRESET,
           SHELL, CGREY, shell, CRESET,
           CALENDAR, CGREY, date, CRESET);

    return 0;
}
