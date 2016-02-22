//
//  WagnerFischerTests.swift
//  WagnerFischerTests
//
//  Created by Sam Soffes on 2/22/16.
//  Copyright © 2016 Caleb Davenport. All rights reserved.
//

import XCTest
import WagnerFischer

class WagnerFischer_OSXTests: XCTestCase {
    func testStringEditSteps() {
        let source = "Caleb Davenport"
        let destination = "Sam Soffes"

        let steps = editSteps(source, destination)
        XCTAssertEqual(applyEditSteps(source, editSteps: steps), destination)
    }
}
