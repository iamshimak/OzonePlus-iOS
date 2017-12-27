//
//  TestSignin.swift
//  OzonePlusTests
//
//  Created by Ahamed Shimak on 12/26/17.
//  Copyright © 2017 Ahamed Shimak. All rights reserved.
//

import XCTest
@testable import OzonePlus

class AuthenticationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignin() {
        let signinExpectation = expectation(description: "Signin Expectation")
        
        let user = SigninManager.SigninUser(username: "shimak2013@gmail.com", password: "Asd123")
        let signinManager = SigninManager()
        
        signinManager.signinUser(signinUser: user, onCompletion: { (response, error) in
            signinExpectation.fulfill()
            XCTAssertNotNil(response)
        })
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testSignup() {
        let signupExpectation = expectation(description: "Signup Expectation")
        
        let user = SignupManager.SignupUser(firstName:"Ahamed",
                                            lastName:"Shimak",
                                            email: "shimak22@gmail.com",
                                            password:"Asd123")
        
        
        let signupManager = SignupManager()
        signupManager.signupWith(signupUser: user) { (response, error) in
            signupExpectation.fulfill()
            XCTAssertNotNil(response)
        }
        
        waitForExpectations(timeout: 15.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
