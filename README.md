## REST API (API Gateway) with Cognito Userpool authorization

1. `pod install`

2. `amplify init`

3. `amplify add api` 
```
? Please select from one of the below mentioned services: REST
? Provide a friendly name for your resource to be used as a label for this category in the project: api20
6480ec
? Provide a path (e.g., /book/{isbn}): /todo
? Choose a Lambda source Create a new Lambda function
? Provide an AWS Lambda function name: apirestcupa4ff1c8e
? Choose the runtime that you want to use: NodeJS
? Choose the function template that you want to use: Serverless ExpressJS function (Integration with API 
Gateway)

Available advanced settings:
- Resource access permissions
- Scheduled recurring invocation
- Lambda layers configuration

? Do you want to configure advanced settings? Yes
? Do you want to access other resources in this project from your Lambda function? No
? Do you want to invoke this function on a recurring schedule? No
? Do you want to configure Lambda layers for this function? No
? Do you want to edit the local lambda function now? No
Successfully added resource apirestcupa4ff1c8e locally.

Next steps:
Check out sample function code generated in <project-dir>/amplify/backend/function/apirestcupa4ff1c8e/src
"amplify function build" builds all of your functions currently in the project
"amplify mock function <functionName>" runs your function locally
"amplify push" builds all of your local backend resources and provisions them in the cloud
"amplify publish" builds all of your local backend and front-end resources (if you added hosting category) and provisions them in the cloud
Succesfully added the Lambda function locally
? Restrict API access Yes
? Who should have access? Authenticated and Guest users
? What kind of access do you want for Authenticated users? create, read, update, delete
? What kind of access do you want for Guest users? create, read, update, delete
Successfully added auth resource locally.
? Do you want to add another path? No
Successfully added resource api206480ec locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud
```

References https://docs.amplify.aws/lib/restapi/getting-started/q/platform/ios#configure-api

4. `amplify push`

5. `xed .`