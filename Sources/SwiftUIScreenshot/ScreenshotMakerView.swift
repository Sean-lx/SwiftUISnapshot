import SwiftUI
import UIKit

/// This View is needed to create a UIViewRepresentable returning a ScreenshotMaker
/// object in a closure.
/// That object is used to capture a screenshot of the View
public struct ScreenshotMakerView: UIViewRepresentable {
  let handler: (ScreenshotMaker) -> Void
  
  public init(_ handler: @escaping (ScreenshotMaker) -> Void) {
    self.handler = handler
  }
  
  public func makeUIView(context: Context) -> ScreenshotMakerUIView {
    let view = ScreenshotMakerUIView(frame: CGRect.zero)
    return view
  }
  
  public func updateUIView(_ uiView: ScreenshotMakerUIView, context: Context) {
    DispatchQueue.main.async {
      handler(uiView)
    }
  }
}

extension View {
  /// Add to the View you need to take a screenshot of.
  /// It creates a ScreenshotMakerView and returns a closure with
  /// a ScreenshotMaker object you can use to take a screenshot
  /// The view is added in an overlay with allowHitTesting false so it doesn't interfere
  /// with your View
  /// - Parameter handler: A closure with a ScreenshotMaker object
  /// - Returns: an overlay containing a ScreenshotMakerView
  public func makeScreenshot(_ handler: @escaping (ScreenshotMaker) -> Void) -> some View {
    let screenshotView = ScreenshotMakerView(handler)
    return overlay(screenshotView.allowsHitTesting(false))
  }
}
