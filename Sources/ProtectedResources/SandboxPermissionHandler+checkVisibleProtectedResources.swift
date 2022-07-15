import Foundation

extension SandboxPermissionsManager {
    internal func checkVisibleProtectedResources() {
        if protectedResources.count == 0 {
            log("no protected resources are visible to app instance")
            log("add protected resources keys to app manifest (Info.plist)", includeCallerLocation: false)
        } else {
            log("following protected resources are visible to app instance: \(protectedResources)", category: .module)
            log("add additional keys to Info.plist to work with other resources")
            log("checking authorization status for protected resources specified in app manifest")
            DispatchQueue.global(qos: .default).sync { [weak self] in
                guard let self = self else { return }
                for resource in self.protectedResources {
                    switch resource {
                    case .camera:
                        log("checking authorization status for camera")
                        let status = mapAVStatusToProtectedResourceAuthStatus(Self.checkCameraAccess())
                        guard status != self.cameraAccessStatus else {
                            return
                        }
                        DispatchQueue.main.async {
                            self.cameraAccessStatus = status
                            log("camera authorization status is \(status)")
                        }
                    case .microphone:
                        log("checking authorization status for microphone")
                        let status = mapAVStatusToProtectedResourceAuthStatus(Self.checkMicrophoneAccess())
                        guard status != self.cameraAccessStatus else {
                            return
                        }
                        DispatchQueue.main.async {
                            self.microphoneAccessStatus = status
                            log("microphone authorization status is \(status)")
                        }
                    case .contacts:
                        log("checking authorization status for camera (not implemented")
                    case .nearbyInteraction:
                        log("checking authorization status for nearby interaction (not implemented)")
                    case .bluetooth:
                        log("checking authorization status for bluetooth (not implemented)")
                    case .faceID:
                        log("checking authorization status for faceID (not implemented)")
                    case .locationAlways:
                        log("checking authorization status for location always (not implemented")
                    case .locationWhenInUse:
                        log("checking authorization status for location when in use (not implemented")
                    case .accelerometer:
                        log("checking authorization status for motion and fitness (not implemented")
                    case .photoLibraryWriteOnly:
                        log("checking authorization status for photo library write-only (not implemented")
                    case .photoLibraryReadWrite:
                        log("checking authorization status for photo library read-write (not implemented")
                    }
                }
            }
        }
    }
}
