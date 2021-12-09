//
//  ApiCaller.swift
//  Combine-Demo
//
//  Created by Alan Liu on 2021/12/09.
//

import UIKit
import Combine

class ApiCaller {
    
    static let shared = ApiCaller()
    
    func fetchCompanyList() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                promise(.success(["Tesla", "Alphabet", "Amazon", "Meta", "Apple", "Microsoft"]))
            }
        }
    }
}
