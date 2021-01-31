//
//  ContentView.swift
//  apiRestCUP
//
//  Created by Law, Michael on 1/30/21.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import AWSPluginsCore

struct ContentView: View {
    var body: some View {
        VStack {
            
            Button("post Todo", action: {
                postTodoFirstTest()
            })
            
            Button("Sign In", action: {
                Amplify.Auth.signIn(username: "username", password: "password") { (result) in
                    switch result {
                    case .success(let signInResult):
                        print("\(signInResult)")
                    case .failure(let error):
                        print("failure \(error)")
                    }
                }
            })
            Button("Sign Out", action: {
                Amplify.Auth.signOut()
            })
            Button("Get Tokens", action: {
                Amplify.Auth.fetchAuthSession { result in
                    do {
                        let session = try result.get()

                        // Get cognito user pool token
                        if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                            let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                            print("Access token - \(tokens.accessToken) ")
                            print("Id token - \(tokens.idToken) ")
                        }

                    } catch {
                        print("Fetch auth session failed with error - \(error)")
                    }
                }
            })
        }
        
    }
    
    func postTodoFirstTest() {
        let request = RESTRequest(path: "/todo", body: "{}".data(using: .utf8))
        Amplify.API.post(request: request) { result in
            switch result {
            case .success(let data):
                let str = String(decoding: data, as: UTF8.self)
                print("Success \(str)")
            case .failure(let apiError):
                print("Failed", apiError)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
