//
//  GifCollectionViewLayout.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import UIKit

protocol GifCollectionViewLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexpath: IndexPath) -> CGFloat
}

class GifCollectionViewLayout: UICollectionViewLayout {
  
  enum LayoutStyle {
    case grid
    case list
  }
  
  private var cache: [UICollectionViewLayoutAttributes] = []
  private let cellPadding: CGFloat = 8
  private let maxColumnCount: Int = 3
  private var contentHeight: CGFloat = 0
  var style: LayoutStyle = .grid
  var delegate: GifCollectionViewLayoutDelegate?
  
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else { return 0 }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    guard let collectionView = collectionView else { return }
    cache = []
    contentHeight = 0
    let columnCount: Int = style == .grid ? maxColumnCount : 1
    let columnWidth: CGFloat =  contentWidth / CGFloat(columnCount)
    
    var xOffsets: [CGFloat] = []
    for column in 0..<columnCount {
      xOffsets.append(CGFloat(column) * columnWidth)
    }
    
    var column = 0
    var yOffset: [CGFloat] = .init(repeating: 0, count: columnCount)
    
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      var height: CGFloat = delegate?.collectionView(collectionView, heightForPhotoAt: indexPath) ?? .zero
      height = height + (cellPadding * 2)
      let frame = CGRect(x: xOffsets[column],
                         y: yOffset[column],
                         width: columnWidth,
                         height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
      
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] = yOffset[column] + height
      
      column = column < (columnCount - 1) ? (column + 1) : 0
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleAttributes: [UICollectionViewLayoutAttributes] = []
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleAttributes.append(attributes)
      }
    }
    return visibleAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
  
}
