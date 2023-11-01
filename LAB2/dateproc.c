#include <rpc/rpc.h>
#include "date.h"
#include <time.h>

/*
 * SD-LAB-2
 *
 * NIU ALUMNO 1: 1566276
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

long *diff_time_1_svc(long *localtime, struct svc_req *arg2) {
    static long remotetime, difftime;
    remotetime = time((long *)0);
    difftime = remotetime + 5 - *localtime;
    return(&difftime);
}

float *mult_1_svc(struct struct_pair *v, struct svc_req *arg2) {
    static float mult;
    mult = (float)v->a*v->b;
    return(&mult);
}
