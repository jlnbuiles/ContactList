//
//  HTTPClient.swift
//  ContactList
//
//  Created by Julian Builes on 1/11/22.
//

import Foundation
import Alamofire
import RxSwift

private enum API {
    static let BaseURL = "https://s3.amazonaws.com/sq-mobile-interview"
}

// this makes our code more testable. it makes it easier to create a mock class that returns dummy data
protocol EntityProtocol {
    associatedtype T: Queryable
    func GETEntityList() -> Observable<T>
}

class BaseEntityRepository<T: Queryable>: EntityProtocol {
    
    func GETEntityList() -> Observable<T> {
        
        return Observable.create { observer in
            let reqURL = API.BaseURL + T.entityListPath()
            AF.request (reqURL).responseDecodable(of: T.self) { resp in
                switch resp.result {
                    case .success:
                        if let responseValue = resp.value { observer.onNext(responseValue) }
                    case let .failure(error):
                        print("Received error: \(error.localizedDescription)\n" + "For URL: \(reqURL)")
                        observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create { }
        }
    }
}
