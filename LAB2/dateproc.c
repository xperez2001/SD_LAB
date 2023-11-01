#include <rpc/rpc.h>
#include "date.h"
#include <time.h>

/*
 * SD-LAB-2
 *
 * NIU ALUMNO 1: XXXXXXXXX
 * NIU ALUMNO 2: XXXXXXXXX
 *
 */
long *bin_date_1_svc(void* arg1, struct svc_req *arg2) {
    static long timevalue;
    timevalue = time((long *)0);
    return(&timevalue);
}

char **str_date_1_svc(long *bintime, struct svc_req *arg2) {
    static char *ptr;
    ptr=ctime(bintime);
    return(&ptr);
}

long *diff_time_1_svc(long *localdate, struct svc_req *arg2) {
    static long timevalue;
    timevalue = time((long *)0) - *localdate;
    return(&timevalue);
}
