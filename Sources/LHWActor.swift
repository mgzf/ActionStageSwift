//
//  LHWActor.swift
//  ActionStageSwift
//
// Copyright (c) 2017年 Hanguang
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

open class LHWActor {
    // MARK: -
    private static var registeredRequestBuilders: [String: AnyClass] = [String: AnyClass]()
    
    open var path: String
    open var requestQueueName: String? = nil
    open var storedOptions: [String: Any]? = [String: Any]()
    open var requiresAuthorization: Bool = false
    open var cancelTimeout: TimeInterval
    open var cancelToken: Any? = nil
    open var multipleCancelTokens: [Any] = [Any]()
    open var cancelled: Bool = false
    
    public required init(path: String) {
        self.cancelTimeout = 0
        self.path = path
    }
    
    // MARK: -
    open class func registerActorClass(_ requestBuilderClass: AnyClass) {
        guard let genericPath = (requestBuilderClass as! LHWActor.Type).genericPath() else {
            print("Error: LHWActor.registerActorClass: genericPath is nil")
            return
        }
        
        registeredRequestBuilders[genericPath] = requestBuilderClass
    }
    
    open class func requestBuilderForGenericPath(_ genericPath: String, path: String) -> LHWActor? {
        let builderClass = registeredRequestBuilders[genericPath]
        if builderClass != nil && builderClass is LHWActor.Type {
            let builderInstance = (builderClass as! LHWActor.Type).init(path: path)
            return builderInstance
        } else {
            return nil
        }
    }
    
    open class func genericPath() -> String? {
        print("Error: LHWActor.genericPath: no default implementation provided")
        return nil
    }
    
    // MARK: -
    open func prepare(options: [String: Any]?) {
    }
    
    open func execute(options: [String: Any]?) {
    }
    
    open func cancel() {
        cancelled = true
    }
    
    open func addCancelToken(token: Any) {
        multipleCancelTokens.append(token)
    }
    
    open func watcherJoined(watcherHandler: LHWHandler, options: [String: Any]?, waitingInActorQueue: Bool) {
    }
    
    open func handleRequestProblem() {
    }
    
}

/*
extension LHWActor: Equatable {
    open static func ==(lhs: LHWActor, rhs: LHWActor) -> Bool {
        if lhs.path == rhs.path &&
            lhs.requestQueueName == rhs.requestQueueName &&
            lhs.requiresAuthorization == rhs.requiresAuthorization &&
            lhs.cancelTimeout == rhs.cancelTimeout &&
            lhs.cancelled == rhs.cancelled {
            return true
        } else {
            return false
        }
    }
}
*/
