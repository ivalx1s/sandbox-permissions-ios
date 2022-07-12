import Foundation

@MainActor
public final class SandboxPermissionHandler {
    
    var protectedResources: Set<ProtectedResource> = []
    
    init() {
        
        for resource in ProtectedResource.allCases {
            if let protectedResource = ProtectedResource(rawValue: resource.rawValue) {
                if Bundle.main.infoDictionary?["\(protectedResource.rawValue)"] as? String != nil {
                    protectedResources.update(
                        with: protectedResource
                    )
                }
            }
        }

        print(self.protectedResources)
    }
    
    func checkPermission(for protectedResource: ProtectedResource) async {
        switch protectedResource {
        case .camera:
            await checkCameraAccess()
        case .microphone:
            await checkMicrophoneAccess()
        case .contacts:
            await checkContactsAccess()
        case .nearbyInteraction:
            await checkNearbyInteractionAccess()
        }
    }
    
    private func checkCameraAccess() async {
        
    }
    
    private func checkMicrophoneAccess() async {
        
    }
    
    private func checkContactsAccess() async {
        
    }
    
    private func checkNearbyInteractionAccess() async {
        
    }
}
