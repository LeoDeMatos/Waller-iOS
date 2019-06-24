//
//  WallPhotosTests.swift
//  WallerTests
//
//  Created by Leonardo de Matos on 04/03/19.
//  Copyright © 2019 Leonardo de Matos Souza. All rights reserved.
//

import XCTest
import Moya

//class WallPhotosTests: XCTestCase {
//    
//    var stubbingProvider = MoyaProvider<UnplashService>(stubClosure: MoyaProvider.immediatelyStub)
//    var photoDataManager: PhotoDataManager!
//    
//    override func setUp() {
//        photoDataManager = PhotoDataManager(unplashService: stubbingProvider)
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testPhotosRequest() {
//        let expectation = self.expectation(description: "photos request done with parsing")
//        _ = photoDataManager.fetchPhotos(page: -1).asDriver().drive(onNext: { (result) in
//                XCTAssertTrue(result)
//                expectation.fulfill()
//            })
//        
//        self.waitForExpectations(timeout: 5.0, handler: nil)
//    }
//    
//    func testDataManagerContainsPhotos() {
//        let expectation = self.expectation(description: "photos array filled after request")
//        _ = photoDataManager.fetchPhotos(page: 0).asDriver().drive(onNext: { result in
//            XCTAssertTrue(result)
//            XCTAssertNotNil(self.photoDataManager.photos)
//            XCTAssert(self.photoDataManager.photos!.count > 0)
//            expectation.fulfill()
//        })
//        
//        self.waitForExpectations(timeout: 5.0, handler: nil)
//    }
//}
