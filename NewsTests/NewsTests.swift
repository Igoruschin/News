//
//  NewsTests.swift
//  NewsTests
//
//  Created by Игорь Ущин on 29.04.2023.
//

import XCTest
@testable import News

final class NewsTests: XCTestCase {

    var net: NetworkManager!
    var data: CDataManager!
    
    
    override func setUpWithError() throws {
        net  = NetworkManager.shared
        data = CDataManager.shared
    }

    override func tearDownWithError() throws {
        net = nil
        data = nil
    }

    func testExample() throws {
        
        net.fetchData { result in
            switch result {
            case .success(_):
                XCTFail("fail success")
            case .failure(let error):
                XCTAssertTrue(error is SomeError)
            }
        }
        
        
        data.fetchFromCoreData { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertTrue(error is Error2)
            }
        }
       
        let arr = [Article]()
        func pre1(indexPath: Int) {
            data.downloadToCoreData(model: arr[indexPath]) { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    XCTAssertTrue(error is Error2)
                }
            }
        }
        
        let cdata = [CDataModel]()
        func pre2(indexPath: Int) {
            data.removeFromCoreData(model: cdata[indexPath]) { result in
                switch result {
                case .success():
                    break
                case .failure(let error):
                    XCTAssertTrue(error is Error2)
                }
            }
        }
    }
    struct SomeError: Error{}
    struct Error2: Error{}

    func testPerform() throws {
        self.measure {
            let selfArr = Array(0...1000000)
            var value = 0
            
            selfArr.forEach {_ in
                value += 0
            }
        }
    }
}
