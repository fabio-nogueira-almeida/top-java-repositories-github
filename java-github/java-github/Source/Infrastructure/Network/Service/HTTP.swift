//
//  HTTPMethod.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 13/07/20.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete = "DELETE"
}
