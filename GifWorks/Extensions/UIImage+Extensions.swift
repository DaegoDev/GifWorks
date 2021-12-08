//
//  UIImage+Extensions.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import UIKit

extension UIImage {
  
  static func loadGif(with data: Data) -> UIImage? {
    guard let imageSource: CGImageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
    let count: Int = CGImageSourceGetCount(imageSource)
    var cgImages: [CGImage] = []
    
    for index in 0..<count {
      if let image = CGImageSourceCreateImageAtIndex(imageSource, index, nil) {
        cgImages.append(image)
      }
    }
    
    let animationImages: [UIImage] = cgImages.map { image in
      return UIImage(cgImage: image)
    }
    
    let duration = UIImage.getGifDuration(for: imageSource)
    return UIImage.animatedImage(with: animationImages, duration: duration)
  }
  
  static func loadGif(with url: URL) -> UIImage? {
    guard let data = try? Data(contentsOf: url) else { return nil }
    return UIImage.loadGif(with: data)
  }
  
  private static func getGifDuration(for imageSource: CGImageSource) -> TimeInterval {
    let count: Int = CGImageSourceGetCount(imageSource)
    var frameDurations: [Double] = []
    for index in 0..<count {
      frameDurations.append(UIImage.getDurationForFrame(at: index, in: imageSource))
    }
    let totalDuration = frameDurations.reduce(.zero, +)
    return TimeInterval(totalDuration)
  }
  
  private static func getDurationForFrame(at index: Int, in imageSource: CGImageSource) -> Double {
    let cfProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, index, nil)
    let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
    
    defer { gifPropertiesPointer.deallocate() }
    
    let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
    if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
      return .leastNonzeroMagnitude
    }
    
    let gifProperties = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
    var delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
    
    if delayObject.doubleValue == .zero {
      delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
    }
    
    return (delayObject as? Double) ?? .leastNonzeroMagnitude
  }
}

