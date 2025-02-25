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
    
    func callLottoAPIWithSingle(round: String) -> Single<Lotto>{
        return Single<Lotto>.create { value in
            
            guard let url = Urls.lotto(round: round).endpoint else {
                value(.failure(APIError.invalidURL))
                return Disposables.create {
                    print("invalid url")
                }
            }
        
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    value(.failure(APIError.unknownResponse))
                    dump(error)
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    value(.failure(APIError.statusError))
                    dump(error)
                    return
                }
                
                if let data {
                    do {
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        value(.success(result))
//                        value.onCompleted()
//                        value.onError(APIError.invalidURL)
                    } catch {
                        value(.failure(APIError.unknownResponse))
                        dump(error)
                    }
                } else {
                    value(.failure(APIError.unknownResponse))
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
