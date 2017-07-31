//
//  Reader.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

class Reader<C, A> {
    let callback: ((C) -> A)

    init(_ callback: @escaping ((C) -> A)) {
        self.callback = callback
    }

    func run(_ context: C) -> A {
        return callback(context)
    }
}
//
//extension Reader {
//    func map<B>(_ f: @escaping ((A) -> B)) -> Reader<C, B> {
//        return Reader<C, B> { context in
//            return f(self.run(context))
//        }
//    }
//
//    func flatMap<B>(_ f: @escaping ((A) -> Reader<C, B>)) -> Reader<C, B> {
//        return Reader<C, B> { context in
//            return f(self.run(context)).run(context)
//        }
//    }
//
//    func zip<B>(_ other: Reader<C, B>) -> Reader<C, Pair<A, B>> {
//        return self.flatMap { a in
//            return other.map({ b in
//                return (a, b)
//            })
//        }
//    }
//
//    func local<D>(_ f: @escaping ((D) -> C)) -> Reader<D, A> {
//        return Reader<D, A> { context in
//            return self.run(f(context))
//        }
//    }
//
//    static func ask(_ c: C) -> Reader<C, C> {
//        return Reader<C, C> { _ in return c }
//    }
//
//    static func pure(_ a: A) -> Reader<C, A> {
//        return Reader<C, A> { _ in return a }
//    }
//}
