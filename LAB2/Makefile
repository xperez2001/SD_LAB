all: rdate dateproc date.h

date.h: date.x
	rpcgen date.x

rdate: rdate.c date.h date_clnt.c date_xdr.c
	gcc -o rdate rdate.c date_clnt.c date_xdr.c

dateproc: dateproc.c date.h date_svc.c date_xdr.c
	gcc -o dateproc dateproc.c date_svc.c date_xdr.c

clean:
	rm rdate dateproc date_* date.h
