import AVFoundation

internal func mapAVStatusToProtectedResourceAuthStatus(_ avStatus: AVAuthorizationStatus) -> ProtectedResourceAuthorizationStatus {
    switch avStatus {
    case .notDetermined:
        return .notDetermined
    case .restricted:
        return .restricted
    case .denied:
        return .denied
    case .authorized:
        return .authorized
    @unknown default:
        return .undefined
    }
}
