#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <limits.h>
#include <string.h>
#include <sys/types.h>
#include <sys/utsname.h>

int main(){

  printf("\nIniciando el programa");

  // Obtener el nombre del host anfitrion
  struct utsname host_info;
  if (uname(&host_info) == -1) { perror("\nError reading hostname"); return(1); }
  char hostname[HOST_NAME_MAX];
  strcpy(hostname, host_info.nodename);

  // Obtener estampa de tiempo
  time_t current_time;
  time(&current_time);

  // Crear el fichero de salida
  char filename[256];
  snprintf(filename, sizeof(filename), "/shared/%s.txt", hostname);

  FILE *file = fopen(filename,"wb");
  if (file == NULL) { perror("\nError opening filename: 'hostname'\nVerifica que /shared es accesible y existe"); return(3); }

  // Escribir en el fichero de salida
  fprintf(file, "Host %s\nTimestamp: %ld\n", hostname, current_time);
  fclose(file);

  // END
  printf("\nArchivo generado: %s\n", filename);

}
