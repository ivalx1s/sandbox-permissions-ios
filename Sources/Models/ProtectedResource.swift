import Foundation
import AVFoundation

public enum ProtectedResource: String, CaseIterable {
    case camera = "NSCameraUsageDescription"
    case microphone = "NSMicrophoneUsageDescription"
    case contacts = "NSContactsUsageDescription"
    case nearbyInteraction = "NSNearbyInteractionUsageDescription"
}

extension ProtectedResource: CustomDebugStringConvertible {
   public  var debugDescription: String {
        switch self {
        case .camera:
            return "camera"
        case .microphone:
            return "microphone"
        case .contacts:
            return "contacts"
        case .nearbyInteraction:
            return "nearby interaction"
        }
    }
}

extension ProtectedResource: CustomStringConvertible {
    public var description: String {
        debugDescription
    }
}


extension AVAuthorizationStatus: CustomDebugStringConvertible {
    public  var debugDescription: String {
        switch self {
        case .notDetermined:
            return "'not determined'"
        case .restricted:
            return "'restricted'"
        case .denied:
            return "'denied'"
        case .authorized:
            return "'authorized'"
        @unknown default:
            return "'unknown'"
        }
     }
}


extension AVAuthorizationStatus: CustomStringConvertible {
    public  var description: String {
        debugDescription
     }
}
