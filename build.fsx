#r "./packages/FAKE/tools/FakeLib.dll"

open Fake
open System.IO

// Properties
let buildDir = Path.Combine(__SOURCE_DIRECTORY__, "build")
let deploymentPackage = Path.Combine(buildDir, "LambdaFunction.zip")

Target "Clean" (
    fun _ ->
    CleanDir buildDir
)

Target "BuildApp" (
    fun _ ->
    let outputFile = Path.Combine(buildDir, "HelloWorld.dll")
    let references =
        [
            // The library we use
            @"packages/Amazon.Lambda.Core/lib/netstandard1.3/Amazon.Lambda.Core.dll"
            // F# and the .NET Core dependencies
            @"packages/FSharp.Core/lib/portable-net45+netcore45/FSharp.Core.dll"
            @"packages/System.Runtime/ref/netstandard1.3/System.Runtime.dll"
            @"packages/System.IO/ref/netstandard1.3/System.IO.dll"
            @"packages/System.Console/ref/netstandard1.3/System.Console.dll"
            @"packages/System.Text.Encoding/ref/netstandard1.3/System.Text.Encoding.dll"
            @"packages/System.Threading.Tasks/ref/netstandard1.3/System.Threading.Tasks.dll"
            // Extra stuff
            @"packages/System.Reflection/ref/netstandard1.3/System.Reflection.dll"
            @"packages/System.Diagnostics.Debug/ref/netstandard1.3/System.Diagnostics.Debug.dll"
            @"packages/System.Linq.Expressions/ref/netstandard1.3/System.Linq.Expressions.dll"
            @"packages/System.Collections/ref/netstandard1.3/System.Collections.dll"

        ] |> List.map (fun x -> Path.Combine(__SOURCE_DIRECTORY__, x))
    for x in references do
        printfn "-- %8b %s" (System.IO.File.Exists(x)) x 
    let options = [
        FscHelper.Target FscHelper.TargetType.Library
        FscHelper.Out outputFile
        FscHelper.References references
        FscHelper.TargetProfile FscHelper.Profile.Netcore
        FscHelper.NoFramework
        FscHelper.Debug true
        FscHelper.FscParam "--nocopyfsharpcore"
    ]
    FscHelper.compile options ["HelloWorld.fs"]
    |> function 0 -> () | c -> failwithf "F# compiler return code: %i" c
    )

Target "Zip" (
    fun _ ->
    !! (buildDir </> "*.dll")
    -- "*.zip"
    |> Zip buildDir deploymentPackage
)


// Default target
Target "Default" (fun _ -> ignore())



// Dependencies
"Clean"
  ==> "BuildApp"
  ==> "Zip"
  ==> "Default"

// start build
RunTargetOrDefault "Default"

