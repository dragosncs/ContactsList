//
//  ContactsViewModel_Tests.swift
//  ContactsListUnitTests
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import XCTest
@testable import ContactsList
import Combine

final class ContactsViewModel_Tests: XCTestCase {
    var viewModel: ContactsViewModel?
    
    
    override func setUpWithError() throws {
       
        viewModel = ContactsViewModel()

    }

    override func tearDownWithError() throws {
        
        viewModel = nil
        
    }
    
    func testFetchContacts() {
        
            let expectation = XCTestExpectation(description: "Fetch contacts expectation")
            
            viewModel?.fetchContacts()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
 
                XCTAssertNotNil(self.viewModel?.activeContacts)
                expectation.fulfill()
            }
            

            wait(for: [expectation], timeout: 10.0)
        }

    
    func testLoadImage() {

        viewModel?.downloadImages()
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
 
            XCTAssertNotNil(self.viewModel?.image)
        }
    }
    

    func testExtractCorrectInitials() {
            
            let name = "Johnny Cage"
            
            let initials = viewModel?.extractInitials(for: name)
            
            XCTAssertEqual(initials, "JC")
        } 
    func testExtractIncorectInitials() {
            
            let name = "Johnny Cage"
            
            let initials = viewModel?.extractInitials(for: name)
            
            XCTAssertNotEqual(initials, "DN")
        }

}
