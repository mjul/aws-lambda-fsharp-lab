# AWS Lambda F\# Lab

Trying out F# on AWS Lambda.

## Status
The build is not working correctly when compiling from Mono to .NET
Core (both with `build.fsx` and `build.sh`).

The `Dockerfile`also tries building an F# application with Microsoft's
own `dotnet` in the Docker image. It is commented out, however, as the
FSC compile step fails.

Manually installing the latest dotnet binaries with the F# generator
and compiler does not resolve the issue (it cannot currently compile
its own generated F# template projects).

The conclusion for now is to wait for a new version of the .NET Core
SDK and tool-chain for Debian.


# Developing with Mono on Mac
Assuming that you already have Mono installed, you need to install the
Paket package manager and use it to download the dependencies. 

    mono .paket/paket.bootstrapper.exe
    mono .paket/paket.exe install

After this, you can build the Lambda deployment package using the
`build.fsx` script.

    mono packages/FAKE/tools/Fake.exe build.fsx


## Deploying the Lambda function 

You can use the `aws` command like client like so to create the function:

    aws lambda create-function \
      --function-name foo\
      --runtime dotnetcore1.0\
      --role lambda_basic_execution \
      --handler "HelloWorld::HelloWorld::handler" --zip-file "fileb://build/LambdaFunction.zip"

Use the `deploy.sh` script to update the function. You must set the `AWS_PROFILE`
environment variable to the name of the AWS profile to use for
deploying. (The profiles are defined in your `~/.aws/config`
configuration). For example if you have a profile named `mjul-lambda-dev`:

    AWS_PROFILE=mjul-lambda-dev ./deploy.sh

