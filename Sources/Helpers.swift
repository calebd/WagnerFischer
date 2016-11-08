//
//  Helpers.swift
//  WagnerFischer
//
//  Created by Caleb Davenport on 2/22/16.
//  Copyright © 2016 Caleb Davenport. All rights reserved.
//

/// A two dimensional data structure.
struct Matrix<Element> {

    // MARK: - Properties

    private var array: [[Element]]


    // MARK: - Initializers

    init(rows: Int, columns: Int, repeatedValue: Element) {
        array = Array(repeating: Array(repeating: repeatedValue, count: columns), count: rows)
    }


    // MARK: - Public

    subscript(row: Int, column: Int) -> Element {
        get {
            return array[row][column]
        }
        set {
            array[row][column] = newValue
        }
    }
}

/// Returns the array with the least elements.
func shortest<T>(_ a: [T], _ b: [T], _ rest: [T]...) -> [T] {
    return ([ b ] + rest).reduce(a, {
        $0.count < $1.count ? $0 : $1
    })
}
