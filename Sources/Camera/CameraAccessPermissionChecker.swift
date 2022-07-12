import Foundation
import AVFoundation

@available(iOS 11, macOS 11, *)
public extension SandboxPermissionHandler {
    @MainActor
    func checkCameraAccessPermission() async {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            case .notDetermined: break
                //cameraAccessStatus = .notDetermined
            case .restricted: break
                //cameraAccessStatus = .restricted
            case .denied: break
                //cameraAccessStatus = .denied
            case .authorized: break
               // cameraAccessStatus = .authorized
            @unknown default: break
                //cameraAccessStatus = .unknown
            }
        }
    }
}
