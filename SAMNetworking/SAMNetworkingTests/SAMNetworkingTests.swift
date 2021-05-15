//
//  SAMNetworkingTests.swift
//  SAMNetworkingTests
//
//  Created by Jonathan Hoche on 15/05/2021.
//

import XCTest
@testable import SAMNetworking

class SAMNetworkingTests: XCTestCase {
    
    private let request = Request()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestParsing_TelAviv() throws {
        let data = getData(from: "MockTelAviv")
        let parseInfo = request.parse(requestDataType: GeonamesData.self, data: data, error: nil)
        XCTAssertTrue(parseInfo.data?.geonames.first?.title == "Tel Aviv University") 
    }
    
    func testRequestParsing_TelAvivWith_thumbnailImgDataNil() throws {
        let data = getData(from: "MockTelAviv")
        let parseInfo = request.parse(requestDataType: GeonamesData.self, data: data, error: nil)
        XCTAssertTrue(parseInfo.data?.geonames[8].thumbnailImgData == nil)
    }
    
    func testRequestParsing_TelAvivWith_summaryNil() throws {
        let data = getData(from: "MockTelAviv")
        let parseInfo = request.parse(requestDataType: GeonamesData.self, data: data, error: nil)
        XCTAssertTrue(parseInfo.data?.geonames[7].summary == nil)
    }
    
    func testRequestParsing_TelAvivWith_titleNil() throws {
        let data = getData(from: "MockTelAviv")
        let parseInfo = request.parse(requestDataType: GeonamesData.self, data: data, error: nil)
        XCTAssertTrue(parseInfo.data?.geonames[6].title == nil)
    }
}

extension SAMNetworkingTests {
    
    private struct GeonamesData: RequestDataType {
        let geonames: [Geoname]
        
        struct Geoname: Decodable {
            let title: String?
            let summary: String?
            let thumbnailImg: String?
            
            var thumbnailImgData: Data?
        }
    }
    
    private func getData(from fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
            
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: url)
        } else {
            return nil
        }
    }
}
