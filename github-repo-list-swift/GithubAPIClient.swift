//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
        
    class func getRepositoriesWithCompletion(completion: (NSArray) -> () ) -> () {
        
        let secret = Secrets() //create instance of Secrets
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()) //create new empty session
        
        if let githubURL = NSURL(string: "https://api.github.com/repositories?client_id=\(secret.clientID)&client_secret=\(secret.clientSecret)") { //decare NSURL
            
            let githubTask = session.dataTaskWithURL(githubURL, completionHandler: { (data, response, error) in //create task with session URL
                if let data = data {
                    
                    do {
                        let responseData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray //serialize and decode JSON Object
                        
                        completion(responseData) //completion handler with response data
                        
                    } catch {
                        print("Fail!")
                    }
                    
                }
                
            })
            
            githubTask.resume() //resume task from pause state
        }
    }
    
}