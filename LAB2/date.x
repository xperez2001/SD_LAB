program DATE_PROG {
	version DATE_VERS {
		long BIN_DATE(void)   = 1; /* Procedimiento 1 */
		string STR_DATE(long) = 2; /* Procedimiento 2 */
		long DIFF_TIME(long)  = 3; /* Procedimiento 3 */
	} = 1; /* Version 1 */
} = 111222333; /* Programa 111222333 */