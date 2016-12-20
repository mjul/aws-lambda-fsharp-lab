# AWS Lambda F\# Lab
Trying out F# on AWS Lambda.

# Developing with Mono on Mac
Assuming that you already have Mono installed, you need to install the
Paket package manager and use it to download the dependencies. 

    mono .paket/paket.bootstrapper.exe
    mono .paket/paket.exe install

After this, you can build the Lambda deployment package using the
`build.fsx` script.

    mono packages/FAKE/tools/Fake.exe build.fsx


## Deploying the Lambda function

    aws lambda create-function \
      --function-name foo\
      --runtime dotnetcore1.0\
      --role lambda_basic_execution \
      --handler "HelloWorld::HelloWorld::handler" --zip-file "fileb://build/LambdaFunction.zip"
