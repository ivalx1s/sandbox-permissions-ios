import Foundation

extension SandboxPermissionHandler {
    internal func checkVisibleProtectedResources() {
        if protectedResources.count == 0 {
            log("no protected resources are visible to app instance")
            log("add protected resources keys to app manifest (Info.plist)", includeCallerLocation: false)
        } else {
            log("following protected resources are visible to app instance: \(protectedResources)", category: .module)
            log("add additional keys to Info.plist to work with other resources")
            log("checking authorization status for protected resources specified in app manifest")
            for resource in self.protectedResources {
                DispatchQueue.global(qos: .default).sync { [weak self] in
                    guard let self = self else { return }
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
                        log("checking authorization status for nearby interaction (not implemented")
                    }
                }
            }
        }
    }
}
