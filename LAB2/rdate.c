#include <stdio.h>
#include <rpc/rpc.h>
#include <time.h>
#include "date.h"

/*
 * SD-LAB-2
 *
 * NIU ALUMNO 1: 1566276
 * NIU ALUMNO 2: XXXXXXXXX
 *
 */
int main (int argc, char *argv[]) {
	CLIENT *cl;
	char *server;
	long *lresult;
	char **sresult;
	long *difftime;
	long *localtime = malloc(sizeof(long));
	struct struct_pair *v = malloc(sizeof(struct struct_pair));
	float *mult;

	if (argc != 2) {
		fprintf(stderr, "Error de uso al llamar al programa: %s hostname\nPor ejemplo: ./rdate master\n", argv[0]);
		exit(1);
	}
	server = argv[1];

	if ((cl = clnt_create(server, DATE_PROG, DATE_VERS, "udp")) == NULL) {
		clnt_pcreateerror(server);
		exit(2);
	}
	
	if ((lresult = bin_date_1(NULL, cl)) == NULL)  {
		clnt_perror(cl, server);
		exit(3);
	}

	printf("Fecha y hora sobre el host (numero) %s = %ld\n", server, *lresult);
	
	if ((sresult = str_date_1(lresult, cl)) == NULL) {
		clnt_perror(cl, server);
		exit(4);	
	}

	printf("Fecha y hora sobre el host (humano) %s = %s\n", server, *sresult);

	*localtime = time((long *)0);
	
	if ((difftime = diff_time_1(localtime, cl)) == NULL)  {
		clnt_perror(cl, server);
		exit(5);
	}
	free(localtime);

	printf("Diferencia entre el reloj del servidor y el reloj local = %ld\n", *difftime);

	v->a = 5;
	v->b = 7;

	if ((mult = mult_1(v, cl)) == NULL) {
		clnt_perror(cl, server);
		exit(6);	
	}

	printf("Resultado de la multiplicacion de %dx%d = %f", v->a, v->b, *mult);
	free(v);

	clnt_destroy(cl);

	return(0);
}
