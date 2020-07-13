//
//  Router.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

// MARK: - Typealias

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

// MARK: - Protocol

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointProtocol
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

// MARK: - Router

class Router<EndPoint: EndPointProtocol>: NetworkRouter {
	
	// MARK: - Property
	
    private var task: URLSessionTask?
    
	// MARK: - Public
	
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
		
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request,
									completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
		
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
	
	// MARK: - Private
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
		let baseUrl = NetworkManager.environmentBaseURL() + route.path
		guard let url = URL(string: baseUrl) else { fatalError("Wrong URL")}
		
		var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
									urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

