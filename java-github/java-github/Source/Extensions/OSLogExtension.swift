//
//  OSLog.swift
//  java-github
//
//  Created by Fábio Nogueira de Almeida on 14/07/20.
//

import Foundation
import os.log

extension OSLog {
	private static var subsystem = Bundle.main.bundleIdentifier!

	static let api = OSLog(subsystem: subsystem, category: "API")
}
