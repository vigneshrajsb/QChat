//
//  Helper.swift
//  QChat
//
//  Created by Vigneshraj Sekar Babu on 7/26/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import UIKit

func convertImageToString(image: UIImage) -> String {
    let imageData = UIImageJPEGRepresentation(image, 0.7)
    guard let encodedData = imageData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) else {fatalError("Error converting image to Encoded String") }
    return encodedData
}

func convertEncodedStringToImage(data: String) -> UIImage {
    
    guard let decodedData = Data(base64Encoded: data, options: Data.Base64DecodingOptions(rawValue: 0)) else { fatalError("Cannot decode avatar data")}
    guard let image = UIImage(data: decodedData, scale: 1.0) else { return UIImage()}
    return image
}


func getCurrentTimeAsString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.string(from: Date())
}
