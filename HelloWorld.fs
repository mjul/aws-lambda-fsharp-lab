namespace HelloWorld

open Amazon.Lambda.Core
open System
open System.IO

type LambdaFunctions = 
    member x.Handler(context: ILambdaContext) =
        Console.WriteLine(sprintf "%s (console)" (context.FunctionName))
        let logger = context.Logger
        logger.Log("Handler invoked (logger)")
        "{\"value\":1}"


