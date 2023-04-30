//
//  NewsTests.swift
//  NewsTests
//
//  Created by Игорь Ущин on 29.04.2023.
//

import XCTest
import CoreData
@testable import News

final class NewsTests: XCTestCase {

    var net: NetworkManager!
    var data: CDataManager!
    var tab: MainTabViewController!
    var news: NewsViewController!
    var fav: FavoritesController!
    var model: Article!
    var cModel: CDataModel!
    var newsCell: NewsTableCell!
    var favCell: FavoriteTableCell!
    var alert: DefaultAlertsImp!
    var date: Date!
    
    
    override func setUpWithError() throws {
        net  = NetworkManager.shared
        data = CDataManager.shared
        tab = MainTabViewController()
        news = NewsViewController()
        fav = FavoritesController()
        model = Article(author: "", title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "")
        cModel = CDataModel()
        newsCell = NewsTableCell()
        favCell = FavoriteTableCell()
        alert = DefaultAlertsImp()
        date = Date()
    }

    override func tearDownWithError() throws {
        net = nil
        data = nil
        tab = nil
        news = nil
        fav = nil
        cModel = nil
        model = nil
        newsCell = nil
        favCell = nil
        alert =  nil
    }

    func testMainFunc() throws {
      
        XCTAssertNotNil(tab, "tab controller not nil")
        XCTAssertNotNil(news, "news controller not nil")
        XCTAssertNotNil(fav, "favorite controller not nil")
        XCTAssertNotNil(newsCell, "newsCell controller not nil")
        XCTAssertNotNil(favCell, "favCell controller not nil")
        
        
        XCTAssertNotNil(alert.alertComplete())
        XCTAssertNotNil(alert.alertDelete())
        
        XCTAssertNotNil(date.getFormattedDate(format: ""))
        
        net.fetchData { result in
            switch result {
            case .success(let data):
                XCTFail("fail success")
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertTrue(error is Error2)
            }
        }
        
        let urlString = "http//"
        let backdropImageURL = URL(string: urlString)!
        
        net.fetchImage(url: backdropImageURL) { Data in
            XCTAssertNotNil(Data)
            XCTFail("fail fetch")
        }
        
        data.fetchFromCoreData { result in
            switch result {
            case .success(let suc ):
                XCTAssertNotEqual(suc, nil)
            case .failure(let error):
                XCTAssertTrue(error is Error2)
            }
        }
       
        
        let arr = model!
        data.downloadToCoreData(model: arr) { result in
                switch result {
                case .success(let suc):
                    XCTAssertNotNil(suc)
                case .failure(let error):
                    XCTAssertTrue(error is Error2)
                }
            }
        
        
         let cdata = cModel!
            data.removeFromCoreData(model: cdata) { result in
                switch result {
                case .success(let suc ):
                    XCTAssertNotNil(suc)
                case .failure(let error):
                    XCTAssertTrue(error is Error2)
                }
            }
    }

    func testModel() throws {
        XCTAssertNotEqual(model.title, nil)
        XCTAssertNotEqual(model.author, nil)
        XCTAssertNotEqual(model.url, nil)
        XCTAssertNotEqual(model.content, nil)
        XCTAssertNotEqual(model.description, nil)
        XCTAssertNotEqual(model.publishedAt, nil)
        XCTAssertNotEqual(model.urlToImage, nil)

    }
    struct Error2: Error{}

    func testPerform() throws {
        self.measure {
            let selfArr = Array(0...100)
            var value = 0
            
            selfArr.forEach {_ in
                value += 0
            }
        }
    }
}
