//
//  NotifierService.swift
//  qTorrent
//
//  Created by Prateek Prakash on 6/18/22.
//

import Alamofire
import SwiftUI

class NotifierService {
    @AppStorage("cloudMessagingToken") private var cloudMessagingToken = ""
    @AppStorage("notifierUrl") private var notifierUrl = ""
    
    static let shared = NotifierService()
    
    public func registerToken() async -> Bool? {
        do {
            let params: [String: Any] = [
                "token": cloudMessagingToken
            ]
            let value = try await AF.request("\(notifierUrl)/api/v1/registerToken", parameters: params).serializingString().value
            return value == "Done"
        } catch {
            return nil
        }
    }
    
    public func deregisterToken() async -> Bool? {
        do {
            let value = try await AF.request("\(notifierUrl)/api/v1/deregisterToken").serializingString().value
            return value == "Done"
        } catch {
            return nil
        }
    }
}
