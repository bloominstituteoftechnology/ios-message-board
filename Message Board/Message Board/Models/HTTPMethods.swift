//
//  HTTPMethods.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

enum HTTPError: Error {
	case non200StatusCode
	case noData
}
