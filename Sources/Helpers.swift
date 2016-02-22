//
//  Helpers.swift
//  WagnerFischer
//
//  Created by Caleb Davenport on 2/22/16.
//  Copyright © 2016 Caleb Davenport. All rights reserved.
//

import Foundation

private class Box: NSObject {
    var value: Any

    init(_ value: Any) {
        self.value = value
    }
}

/// A two dimensional data structure.
struct Matrix<Element> {

    // MARK: - Properties

    let numberOfRows: UInt
    let numberOfColumns: UInt

    private let rows: NSMutableArray
    private let defaultValue: Element


    // MARK: - Initializers

    init(numberOfRows: UInt, numberOfColumns: UInt, repeatedValue: Element) {
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        defaultValue = repeatedValue

        rows = NSMutableArray(capacity: Int(numberOfRows))

        for _ in 0..<numberOfRows {
            rows.addObject(NSMutableArray(capacity: Int(numberOfColumns)))
        }
    }


    // MARK: - Public

    subscript(x: Int, y: Int) -> Element {
        get {
            guard x < rows.count, let row = rows.objectAtIndex(x) as? NSArray else { return defaultValue }
            guard y < row.count, let box = row.objectAtIndex(y) as? Box, value = box.value as? Element else { return defaultValue }
            return value
        }

        set {
            guard x < rows.count, let row = rows.objectAtIndex(x) as? NSMutableArray else { return }

            if y >= row.count {
                for _ in (row.count - 1)..<y {
                    row.addObject(Box(defaultValue))
                }
            }

            row.replaceObjectAtIndex(y, withObject: Box(newValue))
        }
    }
}

/// Returns the array with the least elements.
func shortest<T>(a: [T], _ b: [T], _ rest: [T]...) -> [T] {
    return ([ b ] + rest).reduce(a, combine: {
        $0.count < $1.count ? $0 : $1
    })
}
