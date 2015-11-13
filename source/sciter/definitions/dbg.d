// Copyright 2015 Ramon F. Mendes
// 
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

// port of 'sciter-x-debug.h'
module sciter.definitions.dbg;

public import sciter.sciter_x;
import sciter.sciter_x_types;
import sciter.definitions.api;


VOID SciterSetupDebugOutput ( HWINDOW hwndOrNull, LPVOID param, DEBUG_OUTPUT_PROC pfOutput) { return SAPI().SciterSetupDebugOutput (hwndOrNull,param,pfOutput); }


abstract class debug_output
{
	public this()
	{
	}

	public this(HWINDOW hwnd)
	{
		SciterSetupDebugOutput(hwnd, cast(void*) this, &_output_debug);
	}

	public void setup(HWINDOW hwnd)
	{
		SciterSetupDebugOutput(hwnd, cast(void*) this, &_output_debug);
	}

	abstract void output(OUTPUT_SUBSYTEM subsystem, OUTPUT_SEVERITY severity, wstring text);

	extern(Windows) static void _output_debug(LPVOID param, UINT subsystem, UINT severity, LPCWSTR text, UINT text_length)
	{
		debug_output _this = cast(debug_output) param;
		_this.output(cast(OUTPUT_SUBSYTEM) subsystem, cast(OUTPUT_SEVERITY) severity, text[0..text_length].idup);
	}
}