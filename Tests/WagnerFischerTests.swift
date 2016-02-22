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
        XCTAssertEqual(applyEditSteps(source, editSteps: steps)!, destination)
    }

    func testEmptySource() {
        let source = ""
        let destination = "Sam Soffes"

        let steps = editSteps(source, destination)
        XCTAssertEqual(applyEditSteps(source, editSteps: steps)!, destination)
    }

    func testEmptyDestination() {
        let source = "Caleb Davenport"
        let destination = ""

        let steps = editSteps(source, destination)
        XCTAssertEqual(applyEditSteps(source, editSteps: steps)!, destination)
    }

    func testInvalidEditSteps() {
        let source = "Caleb Davenport"
        let destination = "Sam Soffes"

        let steps = editSteps(source, destination)
        XCTAssertNil(applyEditSteps("", editSteps: steps))

        XCTAssertNil(applyEditSteps("", editSteps: [.Delete(location: 0)]))
        XCTAssertNil(applyEditSteps("", editSteps: [.Delete(location: 1)]))
    }

    func testApplyToEmptySource() {
        XCTAssertEqual(applyEditSteps("", editSteps: [.Insert(location: 0, value: "S".characters.first!)]), "S")
    }

    func testApplyToEmptyDestination() {
        XCTAssertEqual(applyEditSteps("S", editSteps: [.Delete(location: 0)]), "")
    }
}
