import Foundation
import AVFoundation

public enum ProtectedResource: String, CaseIterable {
    case camera = "NSCameraUsageDescription"
    case bluetooth = "NSBluetoothAlwaysUsageDescription"
    case faceID = "NSFaceIDUsageDescription"
    case locationAlways = "NSLocationAlwaysUsageDescription"
    case locationWhenInUse = "NSLocationWhenInUseUsageDescription"
    case accelerometer = "NSMotionUsageDescription"
    case photoLibraryWriteOnly = "NSPhotoLibraryAddUsageDescription"
    case photoLibraryReadWrite = "NSPhotoLibraryUsageDescription"
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
        case .bluetooth:
            return "bluetooth"
        case .faceID:
            return "faceID"
        case .locationAlways:
            return "location always"
        case .locationWhenInUse:
            return "location when in use"
        case .accelerometer:
            return "accelerometer"
        case .photoLibraryWriteOnly:
            return "photo library write-only"
        case .photoLibraryReadWrite:
            return "photo library read-write"
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
