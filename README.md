## REST API (API Gateway) with Cognito Userpool authorization

Amplify iOS version 1.5.5

Amplify CLI version 4.40.0

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

6. Make sure the request works for IAM auth, unauth access. 
```swift
let request = RESTRequest(path: "/todo", body: "{}".data(using: .utf8))
```

7. Update `amplifyconfiguration.json` to use `"authorizationType": "AMAZON_COGNITO_USER_POOLS"`

8. Navigate to your API Gateway, Authorizers, + Create New Authorizer

    8a. Enter Name, Type Cognito

    8b. Select the user pool that was created in this amplify project. note the PoolId under the `CognitoUserPool` in `amplifyconfiguration.json`, the drop down for selecting your Cognito User Pool will look like
    "apirestcup_userpool_ac123-dev ([POOL_ID])"

    8c. Enter `Authorization` as the Token Source

    8d. After you have completed this, click Test and supply your access token

    Reference: https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-enable-cognito-user-pool.html

9. Getting an Access Token
    9a. `amplify console auth` and select User Pool, to open up your AWS Console

    9b. Select Users and groups, and Create user

    9c. Enter "username" and "password", with valid email and mark off verified email, and unmark verifed phone number (kept phone number blank). Or run 
    ```
    aws cognito-idp admin-create-user --user-pool-id [POOL_ID] --username [USER EMAIL]
    ```

    9d. the user should be created with FORCE_CHANGE_PASSWORD, use the admin controls to update this:
    ```
    aws cognito-idp admin-set-user-password --user-pool-id [POOL_ID] --username [USER EMAIL] --password [PASSWORD] --permanent
    ```
    After running this, refreshing the User Pool console should show that the user is in CONFIRMED account status.

    Note: make sure AWS CLI is set up properly, ie. `aws configure`

10. Go back to the app, click "Sign In", then perform "Get ID Token". Copy the ID token from the output and use it in the Authorization Token to test the Authorizer. The response should be 200, with the claims

11. Refresh the page so that the new user pool authorizer will show up when we modify the methods. 

12. Click on Resources, Select ANY under /todo

13. Select Method Request. update the Authorization from AWS_IAM to "CognitoAuthorizer" and finish

14. Click on Actions, and deploy your API to the /dev stage. Then go to something like PostMan, and peform a GET with the URL, with the IDToken in the Authorization Bearer Token header. This should succeed as well.

By default, `Amplify.API` will configure a Cognito token interceptor for the requests when the auth mode is set to `AMAZON_COGNITO_USER_POOLS`. However, the default behavior is to use the access token so the requests in the app will fail with 401. We need to set up the API Gateway to accept the access token instead of the id token.


15. Using `https://jwt.io/`, decoded the Access token to see that there is a scope `aws.cognito.signin.user.admin`. 

16. Back to the API Gateway, update the Method Request's OAth Scopes to include `aws.cognito.signin.user.admin`, and then Click on Action and deploy.

17. Back to Postman, pass in the access token to see that the request is also successful.

18. Go back to the app and perform "post Todo" which will use the access token to perform the request against the API Gateway.


