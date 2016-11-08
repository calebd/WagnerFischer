//
//  WagnerFischer.swift
//  WagnerFischer
//
//  Created by Caleb Davenport on 2/22/16.
//  Copyright © 2016 Caleb Davenport. All rights reserved.
//

/// A single edit step.
public enum EditStep<Value> {
    case insert(location: Int, value: Value)
    case substitute(location: Int, value: Value)
    case delete(location: Int)

    public var location: Int {
        switch self {
        case .insert(let location, _): return location
        case .substitute(let location, _): return location
        case .delete(let location): return location
        }
    }
}

extension EditStep: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .insert(let index, let value):
            return "Insert(\(index), \(value))"
        case .substitute(let index, let value):
            return "Substitute(\(index), \(value))"
        case .delete(let index):
            return "Delete(\(index))"
        }
    }
}

public func editSteps<T>(_ source: [T], _ destination: [T], compare: (T, T) -> Bool) -> [EditStep<T>] {

    // Return all insertions if the source is empty.
    if source.isEmpty {
        return destination.enumerated().map(EditStep.insert)
    }

    // Return all deletions if the destination is empty.
    if destination.isEmpty {
        return (0..<source.count).reversed().map(EditStep.delete)
    }

    var matrix = Matrix<[EditStep<T>]>(
        rows: source.count + 1,
        columns: destination.count + 1,
        repeatedValue: [])

    for i in 1...source.count {
        matrix[i, 0] = (0...i).map(EditStep.delete)
    }

    for j in 1...destination.count {
        matrix[0, j] = (1...j).lazy.map({ $0 - 1 }).map({
            let destinationValue = destination[$0]
            return EditStep.insert(location: $0, value: destinationValue)
        })
    }

    for i in 1...source.count {
        for j in 1...destination.count {
            let destinationValue = destination[j - 1]
            if compare(source[i - 1], destinationValue) {
                matrix[i, j] = matrix[i - 1, j - 1]
            }
            else {
                let a = matrix[i - 1, j] + CollectionOfOne(.delete(location: i - 1))
                let b = matrix[i, j - 1] + CollectionOfOne(.insert(location: j - 1, value: destinationValue))
                let c = matrix[i - 1, j - 1] + CollectionOfOne(.substitute(location: j - 1, value: destinationValue))
                matrix[i, j] = shortest(a, b, c)
            }
        }
    }

    return matrix[source.count, destination.count]
}

public func editSteps<T: Equatable>(_ source: [T], _ destination: [T]) -> [EditStep<T>] {
    return editSteps(source, destination, compare: ==)
}

public func editSteps(_ source: String, _ destination: String) -> [EditStep<Character>] {
    return editSteps(Array(source.characters), Array(destination.characters))
}

public func editDistance<T>(_ source: [T], _ destination: [T], compare: (T, T) -> Bool) -> Int {
    return editSteps(source, destination, compare: compare).count
}

public func editDistance<T: Equatable>(_ source: [T], _ destination: [T]) -> Int {
    return editSteps(source, destination).count
}

public func editDistance(_ source: String, _ destination: String) -> Int {
    return editSteps(source, destination).count
}

public func apply<T>(editSteps: [EditStep<T>], to source: [T]) -> [T]? {
    var destination = source

    for step in editSteps {
        switch step {
        case .insert(let location, let value):
            guard location <= destination.count else { return nil }
            destination.insert(value, at: location)
        case .delete(let location):
            guard location < destination.count else { return nil }
            destination.remove(at: location)
        case .substitute(let location, let value):
            guard location < destination.count else { return nil }
            destination.remove(at: location)
            destination.insert(value, at: location)
        }
    }

    return destination
}

public func apply(editSteps: [EditStep<Character>], to source: String) -> String? {
    guard let characters = apply(editSteps: editSteps, to: Array(source.characters)) else { return nil }
    return String(characters)
}
