struct struct_pair {
	int a;
	int b;
};


program DATE_PROG {
	version DATE_VERS {
		long BIN_DATE(void)   = 1; /* Procedimiento 1 */
		string STR_DATE(long) = 2; /* Procedimiento 2 */
	} = 1; /* Version 1 */
} = 111222333; /* Programa 111222333 */

program NEW_PROG {
	version NEW_VERS {
		long DIFF_TIME(long)  = 1; /* Procedimiento 1 */
		float MULT(struct struct_pair) = 2; /* Procedimiento 2 */
	} = 1; /* Version 1 */
} = 123456789; /* Program 123456789 */
