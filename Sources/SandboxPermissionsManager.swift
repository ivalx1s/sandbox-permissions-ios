import Foundation
import AVFoundation
import os.log


public final class SandboxPermissionsManager {
    static internal let logPerformance = false
    private(set) var protectedResources: Set<ProtectedResource> = []
    
    @Published public internal(set) var cameraAccessStatus: ProtectedResourceAuthorizationStatus = .undefined
    @Published public internal(set) var microphoneAccessStatus: ProtectedResourceAuthorizationStatus = .undefined
    
    public init() {
        for resource in ProtectedResource.allCases {
            if let protectedResource = ProtectedResource(rawValue: resource.rawValue) {
                if Bundle.main.infoDictionary?["\(protectedResource.rawValue)"] as? String != nil {
                    protectedResources.update(
                        with: protectedResource
                    )
                }
            }
        }
        checkVisibleProtectedResources()
    }
}

extension SandboxPermissionsManager {
 
    @MainActor
    public func requestCameraAccess() async {
        Task(priority: .high) {
            cameraAccessStatus = .askingUserPermission
        }
        Task(priority: .high) {
            switch await AVCaptureDevice.requestAccess(for: .video) {
            case true: cameraAccessStatus = .authorized
            case false: cameraAccessStatus = .denied
            }
        }
    }
    
    @MainActor
    public func requestMicrophoneAccess() async {
        Task {
            switch await AVCaptureDevice.requestAccess(for: .audio) {
            case true:
                guard microphoneAccessStatus != .authorized else {
                    return
                }
                microphoneAccessStatus = .authorized
            case false:
                guard microphoneAccessStatus != .denied else {
                    return
                }
                microphoneAccessStatus = .denied
            }
        }
    }
}



extension SandboxPermissionsManager {
    internal static func checkMicrophoneAccess() -> AVAuthorizationStatus {
        var status: AVAuthorizationStatus
        let startT = Date().timeIntervalSince1970 * 1000
        os_signpost(.begin, log: performanceOSLog, name: "typography registration")
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .notDetermined:
            status = .notDetermined
        case .restricted:
            status = .restricted
        case .denied:
            status = .denied
        case .authorized:
            status = .authorized
        @unknown default:
            status = .notDetermined
        }
        let endT = Date().timeIntervalSince1970 * 1000
        if logPerformance {
            log("Microphone authorization took \(Int(endT-startT))ms", category: .performance)
        }
        os_signpost(.end, log: performanceOSLog, name: "typography registration")
        return status
    }
}

extension SandboxPermissionsManager {
    internal static func checkCameraAccess() -> AVAuthorizationStatus {
        var status: AVAuthorizationStatus
        let startT = Date().timeIntervalSince1970 * 1000
        os_signpost(.begin, log: performanceOSLog, name: "typography registration")
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            status = .notDetermined
        case .restricted:
            status = .restricted
        case .denied:
            status = .denied
        case .authorized:
            status = .authorized
        @unknown default:
            status = .notDetermined
        }
        let endT = Date().timeIntervalSince1970 * 1000
        if logPerformance {
            log("Camera authorization took \(Int(endT-startT))ms", category: .performance)
        }
        os_signpost(.end, log: performanceOSLog, name: "typography registration")
        return status
    }
}
