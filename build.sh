#!/bin/sh
FRAMEWORKREFS=`find packages -name '*.dll' | grep 'ref/' | grep netstandard1.3 | sed -e 's/^/-r:/' -e 's/$/ /' | tr -d '\j'`

echo <<EOF
    IGNORING
	-r:packages/System.Globalization/ref/netstandard1.3/System.Globalization.dll \
	-r:packages/System.ObectModel/ref/netstandard1.3/System.ObectModel.dll \
	
	-r:packages/System.Reflection.TypeExtensions/ref/netstandard1.3/System.Reflection.TypeExtensions.dll \
	-r:packages/System.Runtime.Extensions/ref/netstandard1.3/System.Runtime.Extensions.dll \
	-r:packages/System.Text.Encoding/ref/netstandard1.3/System.Text.Encoding.dll \
	-r:packages/System.Threading/ref/netstandard1.3/System.Threading.dll \
	-r:packages/System.Threading.Tasks/ref/netstandard1.3/System.Threading.Tasks.dll \

	-r:packages/System.Linq.Expressions/ref/netstandard1.3/System.Linq.Expressions.dll \
	-r:packages/System.Collections/ref/netstandard1.3/System.Collections.dll \
	\
	"--nocopyfsharpcore" \
	--debug:pdbonly \
	--debug:portable \


	#-r:packages/FSharp.Core/lib/portable-net45+netcore45/FSharp.Core.dll \
	#-r:packages/System.Reflection/ref/netstandard1.3/System.Reflection.dll \
	#-r:packages/System.Diagnostics.Debug/ref/netstandard1.3/System.Diagnostics.Debug.dll \
	#-r:packages/System.Linq.Expressions/ref/netstandard1.3/System.Linq.Expressions.dll \
	#-r:packages/System.Collections/ref/netstandard1.3/System.Collections.dll \
	\

EOF


fsharpc "--out:/Users/mjul/src/github/mjul/aws-lambda-fsharp-lab/build/HelloWorld.dll" \
	"--target:library" \
	"--targetprofile:netcore" \
	"--noframework" \
	"--nocopyfsharpcore" \
	--debug- \
	\
	-r:packages/Amazon.Lambda.Core/lib/netstandard1.3/Amazon.Lambda.Core.dll \
	\
	-r:packages/System.Runtime/ref/netstandard1.3/System.Runtime.dll \
	-r:packages/System.IO/ref/netstandard1.3/System.IO.dll \
	-r:packages/System.Console/ref/netstandard1.3/System.Console.dll \
	-r:packages/System.Text.Encoding/ref/netstandard1.3/System.Text.Encoding.dll \
	-r:packages/System.Threading.Tasks/ref/netstandard1.3/System.Threading.Tasks.dll \
	\
	"HelloWorld.fs"

pushd build
zip "LambdaFunction.zip" HelloWorld.dll
popd
