#if os(iOS)

import Foundation
import AVFoundation

/// AppExtensionでの実行時に利用する想定のNetStreamRenderer
public class AppExtensionStreamRenderer: NetStreamRenderer {

    // MARK:- NetStreamRenderer Implements
    var position: AVCaptureDevice.Position = .unspecified
    var orientation: AVCaptureVideoOrientation = .portrait
    var displayImage: CIImage?
    public var videoFormatDescription: CMVideoFormatDescription? {
        currentStream?.mixer.videoIO.formatDescription
    }
    private weak var currentStream: NetStream? {
        didSet {
            oldValue?.mixer.videoIO.renderer = nil
        }
    }

    // MARK:- Members
    private let ciContext: CIContext!


    // MARK:- Methods

    public init() {
        ciContext = CIContext()
    }

    func render(image: CIImage?) {
    }

    public func attachStream(_ stream: NetStream?) {
        // VideoEffectのレンダリング用にCIContextを紐付けるだけで何もしない
        if let stream: NetStream = stream {
            stream.mixer.videoIO.context = CIContext()
        }
        currentStream = stream
    }
}

#endif
