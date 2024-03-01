//
//  NetworkService.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 21.02.2024.
//

import Alamofire
import Kingfisher

protocol AppNetworkService {
    func fetchAIGeneratedImageUsing(description: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class NetworkService: AppNetworkService {
    private let apiBuilder: AppAPIBuilder

    init(apiBuilder: AppAPIBuilder) {
        self.apiBuilder = apiBuilder
    }

    func fetchAIGeneratedImageUsing(description: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        getUrlForImageBasedOn(description: description) { result in
            switch result {
            case let .success(url):
                self.getImage(from: url) { result in
                    switch result {
                    case let .success(image): completion(.success(image))
                    case let .failure(error): completion(.failure(error))
                    }
                }
            case let .failure(error): completion(.failure(error))
            }
        }
    }

    private func getImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let resource = KF.ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result {
            case let .success(imageResult): completion(.success(imageResult.image))
            case .failure: completion(.failure(NetworkError.invalidURL))
            }
        }
    }

    private func getUrlForImageBasedOn(description: String, completion: @escaping (Result<URL, NetworkError>) -> Void) {
        let endpoint = apiBuilder.getEndpoint()
        let parameters = apiBuilder.getRequestParameters(imageDescription: description)
        AF.request(endpoint,
                   method: .post,
                   parameters: parameters).validate().responseDecodable(of: AIGeneratedModel.self) { response in
            switch response.result {
            case let .success(value):
                guard let imageURLString = value.output.first,
                      let imageURL = URL(string: imageURLString)
                else {
                    completion(.failure(.noDataInServerResponse))
                    return
                }
                completion(.success(imageURL))
            case .failure: completion(.failure(.decodingFailed))
            }
        }
    }
}
