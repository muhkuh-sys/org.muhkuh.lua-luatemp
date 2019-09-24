%module tempsensor

%include "stdint.i"
%include "typemaps.i"

%{
extern "C"
{
	#include "hid.h"
};
%}

%typemap(in) (void *BUFFER_INPUT, int LENGTH_INPUT)
%{
        size_t sizBuffer;
        $1 = (void*)lua_tolstring(L, $argnum, &sizBuffer);
        $2 = sizBuffer;
%}

%typemap(in) (void *BUFFER_OUTPUT, int LENGTH_OUTPUT)
%{
	void *pvOutputData;
	lua_Number sizOutputData;

	sizOutputData = lua_tonumber(L, $argnum);
	pvOutputData = malloc(sizOutputData);
	$1 = pvOutputData;
	$2 = sizOutputData;
%}

/* NOTE: This "argout" typemap can only be used in combination with the above "in" typemap. */
%typemap(argout) (void *BUFFER_OUTPUT, int LENGTH_OUTPUT)
%{
	if( pvOutputData!=NULL && sizOutputData!=0 )
	{
		lua_pushlstring(L, (char*)pvOutputData, sizOutputData);
		free(pvOutputData);
	}
	else
	{
		lua_pushnil(L);
	}
	++SWIG_arg;
%}

%include "hid.h"
