//
//  NetworkService.swift
//  RxLotto
//
//  Created by BAE on 2/24/25.
//

import Foundation

import RxSwift
import RxCocoa

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func callLottoAPI(round: String) -> Observable<Lotto>{
        return Observable<Lotto>.create { value in
            
            guard let url = Urls.lotto(round: round).endpoint else {
                value.onError(APIError.invalidURL)
                return Disposables.create {
                    print("invalid url")
                }
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    value.onError(APIError.unknownResponse)
                    dump(error)
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    dump(error)
                    return
                }
                
                if let data {
                    do {
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        value.onNext(result)
                        value.onCompleted()
//                        value.onError(APIError.invalidURL)
                    } catch {
                        value.onError(APIError.unknownResponse)
                        dump(error)
                    }
                } else {
                    value.onError(APIError.unknownResponse)
                    dump(error)
                }
            }
            .resume()
            return Disposables.create {
                print("통신 끝")
            }
        }
    }
}

//final class NetworkService {
//    static let shared = NetworkService()
//    
//    private init() { }
//    
//    func callBoxOffice(date:String) -> Observable<Movie> {
//        return Observable<Movie>.create { value in
//            let urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=51051702432c7c539528cbcc7b0f991a&targetDt=\(date)"
//            
//            guard let url = URL(string: urlString) else {
//                value.onError(APIError.invalidURL)
//                return Disposables.create {
//                    print("긋!")
//                }
//            }
//            
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error {
//                    value.onError(APIError.unknownResponse)
//                }
//                
//                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                    value.onError(APIError.statusError)
//                    return
//                }
//                
//                if let data = data {
//                    do {
//                        let result = try JSONDecoder().decode(Movie.self, from: data)
//                        // moive에서 에러를 뿜으면 상위 옵저버블인 버튼탭까지 disposed 되어버린다. 그럼 구독이 끝났기 때무네 이다음부턴 정상적인 통신이 안된다
//                        // Rx에서의 에러 핸들링
//                        // 에러를 아예 안보내거나 캐치하는 방법등으로 이런 현상을 피한다.
//                        value.onError(APIError.statusError)
////                        value.onNext(result)
////                        value.onCompleted()
//                    } catch {
//                        value.onError(APIError.unknownResponse)
//                    }
//                } else {
//                    value.onError(APIError.unknownResponse)
//                }
//            }
//            .resume()
//            return Disposables.create {
//                print("끝")
//            }
//        }
//    }
//    
//    func callBoxOfficeWithSingle(date: String) -> Single<Movie> {
//        return Single<Movie>.create { value in
//            let urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=51051702432c7c539528cbcc7b0f991a&targetDt=\(date)"
//            
//            guard let url = URL(string: urlString) else {
//                value(.failure(APIError.invalidURL))
//                return Disposables.create {
//                    print("긋!")
//                }
//            }
//            
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error {
//                    value(.failure(APIError.unknownResponse))
//                }
//                
//                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                    value(.failure(APIError.statusError))
//                    return
//                }
//                
//                if let data = data {
//                    do {
//                        let result = try JSONDecoder().decode(Movie.self, from: data)
////                        value(.success(result))
//                        value(.failure(APIError.statusError))
//                    } catch {
//                        value(.failure(APIError.unknownResponse))
//                    }
//                } else {
//                    value(.failure(APIError.unknownResponse))
//                }
//            }
//            .resume()
//            return Disposables.create {
//                print("끝")
//            }
//        }
//    }
//}
