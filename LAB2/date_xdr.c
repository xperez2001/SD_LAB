/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "date.h"

bool_t
xdr_struct_pair (XDR *xdrs, struct_pair *objp)
{
	register int32_t *buf;

	 if (!xdr_int (xdrs, &objp->a))
		 return FALSE;
	 if (!xdr_int (xdrs, &objp->b))
		 return FALSE;
	return TRUE;
}
