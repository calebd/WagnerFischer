//
//  WagnerFischerTests.swift
//  WagnerFischerTests
//
//  Created by Sam Soffes on 2/22/16.
//  Copyright © 2016 Caleb Davenport. All rights reserved.
//

import XCTest
import WagnerFischer

final class WagnerFischerTests: XCTestCase {
    func testStringEditSteps() {
        let source = "Caleb Davenport"
        let destination = "Sam Soffes"

        let steps = editSteps(source, destination)
        XCTAssertEqual(apply(editSteps: steps, to: source)!, destination)
    }

    func testEmptySource() {
        let source = ""
        let destination = "Sam Soffes"

        let steps = editSteps(source, destination)
        XCTAssertEqual(apply(editSteps: steps, to: source)!, destination)
    }

    func testEmptyDestination() {
        let source = "Caleb Davenport"
        let destination = ""

        let steps = editSteps(source, destination)
        XCTAssertEqual(apply(editSteps: steps, to: source)!, destination)
    }

    func testInvalidEditSteps() {
        let source = "Caleb Davenport"
        let destination = "Sam Soffes"

        let steps = editSteps(source, destination)
        XCTAssertNil(apply(editSteps: steps, to: ""))

        XCTAssertNil(apply(editSteps: [.delete(location: 0)], to: ""))
        XCTAssertNil(apply(editSteps: [.delete(location: 1)], to: ""))
    }

    func testApplyToEmptySource() {
        XCTAssertEqual(apply(editSteps: [.insert(location: 0, value: "S".characters.first!)], to: ""), "S")
    }

    func testApplyToEmptyDestination() {
        XCTAssertEqual(apply(editSteps: [.delete(location: 0)], to: "S"), "")
    }

    func testPerformance() {
        let source = "Food truck actually man braid, letterpress XOXO quinoa sartorial. Narwhal before they sold out mixtape next level, freegan yuccie stumptown pour-over try-hard lomo keffiyeh waistcoat sriracha selvage. Truffaut cray venmo ethical deep v freegan. Hashtag offal normcore schlitz cold-pressed, food truck"
        let destination = "Bicycle rights paleo godard, tofu man braid green juice umami keffiyeh tattooed brunch hella. Williamsburg chartreuse butcher vinyl. Freegan thundercats quinoa roof party tote bag, actually schlitz +1 brooklyn yuccie vinyl. Listicle mumblecore occupy banh mi asymmetrical polaroid. Four loko viral pug"

        measure {
            _ = editSteps(source, destination)
        }
    }
}
