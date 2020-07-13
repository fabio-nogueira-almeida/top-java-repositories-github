//
//  EndPointType.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

protocol EndPointProtocol {
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var headers: HTTPHeaders? { get }
}
