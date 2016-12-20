#!/bin/sh

function log {
    echo "----------------------------------------------------------------"
    echo $1
    echo "----------------------------------------------------------------"
}

log "Using profile: " ${AWS_PROFILE}

#aws --profile ${AWS_PROFILE} lambda list-functions

aws --profile ${AWS_PROFILE} lambda \
    update-function-code \
    --function-name lambdaHelloWorld --zip-file fileb://build/LambdaFunction.zip

log "Updating configuration..."

aws --profile ${AWS_PROFILE} lambda \
      update-function-configuration \
      --function-name lambdaHelloWorld \
      --handler 'HelloWorld::HelloWorld.LambdaFunctions::Handler'

log "Invoking..."

aws --profile ${AWS_PROFILE} lambda \
    invoke \
    --function-name lambdaHelloWorld \
    --log-type Tail \
    lambda-result.txt 

log "RESULT"

cat lambda-result.txt
 
